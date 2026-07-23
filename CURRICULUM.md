# linuxlab Curriculum

Linux runs most of the internet, nearly all cloud infrastructure, and a
large share of corporate backend systems. Whether the job title is
Sysadmin, DevOps Engineer, SRE, Cloud Engineer, Security Analyst, or
even just "Backend Developer" or "Data Engineer," being genuinely
comfortable at a Linux shell — not just able to Google commands — is
one of the highest-leverage, most job-agnostic skills in IT. This
curriculum is built to take you from "I can navigate a terminal" to
"I can run and secure a real Linux server," through 43 hands-on,
auto-graded tasks.

There's no substitute for typing the commands yourself. Every task here
sets up a real (if small) broken/incomplete system and asks you to fix
it — not multiple choice, not fill-in-the-blank. `lab check` runs the
same kind of verification a senior engineer would eyeball your work
with.

## How to use this guide

0. Run `lab doctor` once before you start. It tells you exactly which
   of the 11 categories will fully work in your current environment
   (container vs VM, what's installed, what kernel features are
   available) so a missing package doesn't look like a broken task.
1. Work through the tracks roughly in order — later tasks sometimes
   assume earlier ones are done (e.g. LVM's extend-lv task needs
   lvm-basics completed first; resource-limits needs the original
   systemd-service task's unit to exist). `lab show <id>` will tell you
   if a task depends on system state from another one.
2. Use `lab hint` liberally — hints are staged from vague to exact, so
   you control how much you want spoiled.
3. Don't skip `lab show` even when a task "sounds easy" — the checker
   verifies specific details (exact permissions, exact filenames) that
   the scenario text spells out.
4. When you finish a track, take a moment to explain out loud what you
   just did and why it matters — that's what turns a completed
   checklist into something you can talk about in an interview.

## Learning path

### Track 1 — Foundations (do this first, no exceptions)
`01-fundamentals` (6 tasks): file permissions & ownership, process
management, find/locate, sed text processing, tar/gzip archiving, shell
scripting.

**Why it matters:** every other track assumes you're fluent here. File
permissions and process control are the single most common source of
"why doesn't this work" tickets in every Linux-adjacent job. The shell
scripting task specifically builds the habit of automating instead of
repeating yourself — the mental shift that separates a Linux user from
a Linux engineer.

### Track 2 — Day-to-day system administration
`02-sysadmin` (6 tasks): users & groups, log analysis, package
management, systemd service basics, disk usage investigation, service
troubleshooting.

**Why it matters:** this is the bread-and-butter of a Linux Sysadmin or
Support Engineer role — onboarding accounts, reading logs under
pressure, keeping software current, and diagnosing "the service won't
start" tickets using the tools systemd actually gives you instead of
guesswork.

### Track 3 — Security fundamentals
`03-security` (6 tasks): cron scheduling, least-privilege sudoers, SSH
hardening, firewall rules (ufw), file integrity verification, password
aging policy.

**Why it matters:** "least privilege" and "harden the attack surface"
aren't abstract security-team slogans — they're daily sysadmin habits.
Every one of these tasks maps directly onto a real audit finding
(overly broad sudo access, password-based SSH, an open firewall) that
shows up in every compliance framework from SOC 2 to PCI-DSS.

### Track 4 — Networking
`04-networking` (4 tasks): IP addressing, DNS overrides, port
identification, SSH key authentication.

**Why it matters:** you cannot troubleshoot "the app can't reach the
database" without these basics. SSH key auth specifically is table
stakes for any CI/CD pipeline, and "what's listening on this port" is
one of the first things you check when triaging an incident.

### Track 5 — Storage essentials
`05-storage` (3 tasks): log cleanup by age, logrotate, a reusable
backup script.

**Why it matters:** unmanaged disk growth is one of the most common
causes of production outages, and it's entirely preventable with the
tools in this track. The backup script task is your first real
integration exercise — combining Track 1's scripting with real file
operations.

### Track 6 — Storage at the block level: LVM
`06-storage-lvm` (4 tasks): loop-device filesystems, LVM (physical
volumes → volume groups → logical volumes), online resize, persistent
mounts via /etc/fstab.

**Why it matters:** LVM is how real production storage is managed —
resizable, snapshot-able, decoupled from physical disk boundaries.
Anyone doing infrastructure work on bare metal or VMs (as opposed to
purely managed cloud storage) needs this. It's also a classic
interview whiteboard topic for Linux Sysadmin and Infrastructure roles.

### Track 7 — systemd in depth
`07-systemd-deep` (4 tasks): timers (the modern cron replacement),
resource limits via cgroups, service dependency ordering, and
diagnosing a crash-looping service with journalctl.

**Why it matters:** almost every modern Linux distro runs systemd.
Knowing it at the level of "start/stop/enable" gets you through Track
2; knowing it at *this* level — timers, resource caps, dependency
graphs, log forensics — is what separates a junior sysadmin from
someone trusted to design a production service topology.

### Track 8 — Mandatory Access Control & auditing
`08-security-mac` (3 tasks): AppArmor enforce mode, writing an AppArmor
profile from scratch, and setting up auditd file-access watches.

**Why it matters:** file permissions alone don't stop a compromised
process from doing damage — that's what Mandatory Access Control (MAC)
systems like AppArmor (Debian/Ubuntu) and SELinux (RHEL/CentOS/Fedora)
are for. auditd's watch rules are exactly how compliance frameworks
require you to prove "we know when sensitive files were touched." This
track is squarely aimed at security-adjacent and compliance-heavy IT
roles.

### Track 9 — Backups & recovery
`09-backups-recovery` (3 tasks): rsync mirroring, restoring from an
archive with checksum verification, and a fully automated (systemd
timer-driven) nightly backup.

**Why it matters:** "we have backups" and "we have *tested, working*
backups" are very different claims — the restore-verification task
specifically drills that distinction. This track is the practical,
integrated payoff of Tracks 1, 5, and 7 combined.

### Track 10 — Containers
`10-containers` (3 tasks): running and inspecting a container,
building a custom image, and connecting two containers over a
user-defined network.

**Why it matters:** containers are how most software ships today.
These three tasks are the minimum fluency expected of almost any
DevOps, SRE, or backend role — running someone else's image, building
your own, and understanding container networking well enough to debug
"my services can't see each other."

### Track 11 — Capstone
`11-capstone` (1 task): a single scenario with three simultaneous,
unrelated problems (a runaway process, an insecure file, a disk hog)
and no hand-holding about which is which — exactly like a real page.

**Why it matters:** real incidents don't announce their category. This
is a timed-feeling, no-training-wheels exercise in triage: figure out
what's actually wrong using the same tools from Tracks 1 and 2, under
the mild pressure of not being told the answer up front.

## Career relevance at a glance

| If you're aiming for... | Prioritize these tracks |
|---|---|
| Linux Sysadmin / IT Support | 1, 2, 3, 5, 6, 7 |
| DevOps Engineer / SRE | 1, 2, 4, 7, 9, 10, 11 |
| Cloud Engineer | 1, 4, 6, 9, 10 |
| Security Analyst / Compliance | 1, 3, 8, 9 |
| Backend / Data Engineer (Linux-adjacent) | 1, 2, 4, 10 |

No matter the target role, Track 1 is non-negotiable — everything else
assumes it.

## After you finish all 43

- Add your own tasks with `tasks/_template/` (see the main
  [README](./README.md#adding-your-own-tasks)) targeting whatever your
  next job actually needs — Kubernetes basics, cloud CLI tools (aws/gcloud/az),
  Ansible, Terraform, or a specific compliance framework are natural
  next steps this lab doesn't cover yet.
- Take what you built here and put it on a resume or portfolio
  honestly: "completed a 43-task hands-on Linux curriculum covering
  systemd, LVM, AppArmor, and container fundamentals" is a genuine,
  defensible claim if you did the work — and you'll be able to back it
  up in an interview because you actually typed every command.
