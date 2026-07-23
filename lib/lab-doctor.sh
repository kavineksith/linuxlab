#!/usr/bin/env bash
# linuxlab environment doctor — checks prerequisites for each task category
# before the learner hits a confusing mid-task failure.

# Each check function prints one line via check_pass/check_warn/check_fail
# and returns 0 (pass/warn, non-blocking) or 1 (fail, blocking) so callers
# can tally results.

DOCTOR_PASS=0
DOCTOR_WARN=0
DOCTOR_FAIL=0

check_pass() { printf '  %s %s\n' "${C_GREEN}✔${C_RESET}" "$1"; DOCTOR_PASS=$((DOCTOR_PASS+1)); }
check_warn() { printf '  %s %s\n' "${C_YELLOW}!${C_RESET}" "$1"; DOCTOR_WARN=$((DOCTOR_WARN+1)); }
check_fail() { printf '  %s %s\n' "${C_RED}✘${C_RESET}" "$1"; DOCTOR_FAIL=$((DOCTOR_FAIL+1)); }

doctor_section() { printf '\n%s\n' "${C_BOLD}${C_CYAN}$1${C_RESET}"; }

# --- individual checks ----------------------------------------------------

doctor_check_os() {
  if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    case "${ID:-}:${ID_LIKE:-}" in
      *debian*|*ubuntu*)
        check_pass "OS: $PRETTY_NAME (Debian-based — fully supported)"
        ;;
      *)
        check_warn "OS: ${PRETTY_NAME:-unknown} — this project targets Debian/Ubuntu/Mint; commands like apt-get won't exist elsewhere."
        ;;
    esac
  else
    check_warn "Could not read /etc/os-release — unable to confirm this is a Debian-based system."
  fi
}

doctor_check_container() {
  if in_container; then
    check_warn "Running inside a container — systemd, LVM/loop devices, AppArmor, and auditd tasks will likely fail here unless run with --privileged --cap-add=ALL, and some (AppArmor's kernel LSM, audit netlink) often don't work even then. Consider a VM for those tracks."
  else
    check_pass "Not running inside a container — full native access available (kernel permitting)."
  fi
}

doctor_check_privileges() {
  if [ "$(id -u)" -eq 0 ]; then
    check_pass "Running as root."
  elif sudo -n true 2>/dev/null; then
    check_pass "Passwordless sudo available."
  elif command -v sudo >/dev/null 2>&1; then
    check_warn "sudo is installed but needs a password interactively — most tasks will still work, just expect a prompt."
  else
    check_fail "No sudo available and not root — most sysadmin/security tasks require elevated privileges."
  fi
}

doctor_check_systemd() {
  if [ -d /run/systemd/system ] && command -v systemctl >/dev/null 2>&1; then
    ver="$(systemctl --version 2>/dev/null | head -n1 || true)"
    check_pass "systemd is PID 1 and systemctl works ($ver). Affects: sysadmin (systemd-service, service-troubleshooting), systemd-deep."
  elif command -v systemctl >/dev/null 2>&1; then
    check_fail "systemctl exists but systemd is not PID 1 (common in containers) — systemd-dependent tasks will not work here."
  else
    check_fail "systemctl not found — install systemd or use a systemd-based distro. Affects: sysadmin (systemd-service, service-troubleshooting), systemd-deep."
  fi
}

doctor_check_loop_lvm() {
  if command -v losetup >/dev/null 2>&1; then
    if losetup -f >/dev/null 2>&1; then
      check_pass "losetup can find a free loop device. Affects: storage-lvm."
    else
      check_fail "losetup is installed but couldn't find/allocate a free loop device (needs root or is exhausted). Affects: storage-lvm."
    fi
  else
    check_fail "losetup not found (util-linux). Affects: storage-lvm."
  fi
  if command -v pvcreate >/dev/null 2>&1 && command -v vgcreate >/dev/null 2>&1 && command -v lvcreate >/dev/null 2>&1; then
    check_pass "LVM2 tools (pvcreate/vgcreate/lvcreate) present. Affects: storage-lvm."
  else
    check_fail "LVM2 tools not found — install the 'lvm2' package. Affects: storage-lvm."
  fi
}

doctor_check_apparmor() {
  if [ -d /sys/kernel/security/apparmor ]; then
    check_pass "AppArmor LSM is active in this kernel."
  else
    check_fail "AppArmor LSM not active in this kernel (common inside containers, or on non-Ubuntu/Debian kernels). Affects: security-mac (apparmor tasks)."
  fi
  if command -v aa-status >/dev/null 2>&1; then
    check_pass "aa-status / apparmor-utils installed. Affects: security-mac."
  else
    check_fail "apparmor-utils not installed (aa-status, aa-enforce, aa-complain missing). Affects: security-mac."
  fi
}

doctor_check_auditd() {
  if command -v auditctl >/dev/null 2>&1; then
    check_pass "auditctl (audit package) installed. Affects: security-mac (audit-watch)."
  else
    check_fail "auditctl not found — install the 'auditd' package. Affects: security-mac (audit-watch)."
  fi
  if sudo auditctl -s >/dev/null 2>&1 || auditctl -s >/dev/null 2>&1; then
    check_pass "Audit netlink is reachable — auditd rules should work."
  else
    check_warn "Could not reach the audit netlink socket (common in containers — the kernel audit subsystem often isn't exposed even with --privileged). Affects: security-mac (audit-watch)."
  fi
}

doctor_check_network() {
  if command -v curl >/dev/null 2>&1; then
    if curl -s -m 4 -o /dev/null -w '' https://deb.debian.org 2>/dev/null; then
      check_pass "Outbound internet access confirmed (reached deb.debian.org). Affects: apt package-management task, container image pulls."
    else
      check_warn "Could not reach the internet (deb.debian.org). apt install and container image pulls will fail until network access is available."
    fi
  else
    check_warn "curl not installed — could not test network connectivity."
  fi
}

doctor_check_containers_engine() {
  local engine=""
  if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
    engine="docker"
  elif command -v podman >/dev/null 2>&1; then
    engine="podman"
  fi
  if [ -n "$engine" ]; then
    check_pass "$engine is installed and reachable. Affects: containers category."
  else
    check_warn "Neither a working docker nor podman found on THIS system. The containers category is meant to be run on your host machine, not inside the linuxlab container itself — see README for install instructions."
  fi
}

doctor_check_core_tools() {
  local missing=""
  for tool in find grep awk sed tar gzip chmod chown useradd getent stat; do
    command -v "$tool" >/dev/null 2>&1 || missing="$missing $tool"
  done
  if [ -z "$missing" ]; then
    check_pass "All core coreutils/findutils tools present. Affects: fundamentals, sysadmin, most tracks."
  else
    check_fail "Missing core tools:$missing — install coreutils/findutils/grep/gawk/sed/tar."
  fi
  if command -v rsync >/dev/null 2>&1; then
    check_pass "rsync installed. Affects: backups-recovery."
  else
    check_fail "rsync not installed. Affects: backups-recovery (rsync-incremental)."
  fi
  if command -v logrotate >/dev/null 2>&1; then
    check_pass "logrotate installed. Affects: storage (log-rotation)."
  else
    check_fail "logrotate not installed. Affects: storage (log-rotation)."
  fi
  if command -v ufw >/dev/null 2>&1; then
    check_pass "ufw installed. Affects: security (firewall-ufw)."
  else
    check_fail "ufw not installed. Affects: security (firewall-ufw)."
  fi
  if command -v ss >/dev/null 2>&1 || command -v netstat >/dev/null 2>&1; then
    check_pass "ss/netstat available. Affects: networking (port-scanning)."
  else
    check_fail "Neither ss nor netstat found (iproute2/net-tools). Affects: networking (port-scanning)."
  fi
  if command -v python3 >/dev/null 2>&1 || command -v nc >/dev/null 2>&1; then
    check_pass "python3 or nc available (used to simulate a listener). Affects: networking (port-scanning)."
  else
    check_warn "Neither python3 nor nc found — the port-scanning task's setup.sh won't be able to start its demo listener."
  fi
}

# --- top-level entry point ------------------------------------------------

run_doctor() {
  DOCTOR_PASS=0; DOCTOR_WARN=0; DOCTOR_FAIL=0
  head1 "linuxlab environment doctor"
  echo "Checking prerequisites for all 11 task categories..."

  doctor_section "System"
  doctor_check_os
  doctor_check_container
  doctor_check_privileges

  doctor_section "Core tooling (fundamentals, sysadmin, security, networking, storage, backups)"
  doctor_check_core_tools

  doctor_section "Network"
  doctor_check_network

  doctor_section "systemd (sysadmin: systemd-service/service-troubleshooting, systemd-deep)"
  doctor_check_systemd

  doctor_section "LVM & loop devices (storage-lvm)"
  doctor_check_loop_lvm

  doctor_section "AppArmor (security-mac)"
  doctor_check_apparmor

  doctor_section "auditd (security-mac)"
  doctor_check_auditd

  doctor_section "Container engine (containers — run on your HOST, not nested)"
  doctor_check_containers_engine

  echo
  head1 "Summary"
  echo "  ${C_GREEN}$DOCTOR_PASS passed${C_RESET}   ${C_YELLOW}$DOCTOR_WARN warnings${C_RESET}   ${C_RED}$DOCTOR_FAIL failed${C_RESET}"
  echo
  if [ "$DOCTOR_FAIL" -gt 0 ]; then
    echo "Some categories won't fully work in this environment yet — see the"
    echo "✘ lines above for exactly what's missing and which tasks it affects."
    echo "Run 'lab list' and stick to tasks marked env: both/container for now,"
    echo "or fix the failed items above (often: sudo apt-get install <package>)."
  elif [ "$DOCTOR_WARN" -gt 0 ]; then
    echo "Mostly ready — a few warnings above are worth a look but shouldn't"
    echo "block most of the curriculum."
  else
    echo "Environment looks fully ready for all 43 tasks."
  fi
}
