#!/usr/bin/env bash
# linuxlab core library — sourced by bin/lab
# Provides task discovery, progress persistence, and output helpers.

LAB_ROOT="${LAB_ROOT:-/opt/linuxlab}"
LAB_TASKS_DIR="${LAB_TASKS_DIR:-$LAB_ROOT/tasks}"
LAB_STATE_DIR="${LAB_STATE_DIR:-$HOME/.local/share/linuxlab}"
LAB_PROGRESS_FILE="$LAB_STATE_DIR/progress.tsv"
LAB_WORKDIR="${LAB_WORKDIR:-$HOME/linuxlab-workspace}"

mkdir -p "$LAB_STATE_DIR" "$LAB_WORKDIR"
touch "$LAB_PROGRESS_FILE"

# --- colors -----------------------------------------------------------
if [ -t 1 ]; then
  C_RESET=$'\033[0m'; C_BOLD=$'\033[1m'
  C_GREEN=$'\033[32m'; C_RED=$'\033[31m'; C_YELLOW=$'\033[33m'
  C_BLUE=$'\033[34m'; C_CYAN=$'\033[36m'; C_DIM=$'\033[2m'
else
  C_RESET=""; C_BOLD=""; C_GREEN=""; C_RED=""; C_YELLOW=""; C_BLUE=""; C_CYAN=""; C_DIM=""
fi

info()  { printf '%s\n' "${C_BLUE}==>${C_RESET} $*"; }
ok()    { printf '%s\n' "${C_GREEN}✔${C_RESET} $*"; }
warn()  { printf '%s\n' "${C_YELLOW}!${C_RESET} $*"; }
fail()  { printf '%s\n' "${C_RED}✘${C_RESET} $*"; }
head1() { printf '%s\n' "${C_BOLD}${C_CYAN}$*${C_RESET}"; }

# --- task discovery -----------------------------------------------------
# Task id format: <category-dir>/<task-dir>, e.g. 01-fundamentals/001-file-permissions
list_task_ids() {
  find "$LAB_TASKS_DIR" -mindepth 3 -maxdepth 3 -name meta.sh | \
    grep -v '^'"$LAB_TASKS_DIR"'/_template/' | \
    sed "s#^$LAB_TASKS_DIR/##; s#/meta.sh\$##" | sort
}

task_dir() { echo "$LAB_TASKS_DIR/$1"; }

# Loads TITLE, CATEGORY, DIFFICULTY, ENVIRON, DESCRIPTION, OBJECTIVE into current shell
load_task_meta() {
  local id="$1" dir
  dir="$(task_dir "$id")"
  if [ ! -f "$dir/meta.sh" ]; then
    fail "Unknown task: $id"
    return 1
  fi
  # shellcheck disable=SC1090
  source "$dir/meta.sh"
}

task_exists() { [ -f "$(task_dir "$1")/meta.sh" ]; }

# --- progress persistence -----------------------------------------------
# progress.tsv lines: <task_id>\t<status:started|done>\t<hint_level>\t<timestamp>
progress_line() { grep -P "^$1\t" "$LAB_PROGRESS_FILE" 2>/dev/null | tail -n1; }

progress_status() {
  local line; line="$(progress_line "$1")"
  [ -z "$line" ] && { echo "not_started"; return; }
  echo "$line" | cut -f2
}

progress_hint_level() {
  local line; line="$(progress_line "$1")"
  [ -z "$line" ] && { echo 0; return; }
  echo "$line" | cut -f3
}

progress_set() {
  local id="$1" status="$2" hint_level="${3:-$(progress_hint_level "$1")}"
  local tmp; tmp="$(mktemp)"
  grep -vP "^$id\t" "$LAB_PROGRESS_FILE" > "$tmp" 2>/dev/null || true
  printf '%s\t%s\t%s\t%s\n' "$id" "$status" "$hint_level" "$(date -Iseconds)" >> "$tmp"
  mv "$tmp" "$LAB_PROGRESS_FILE"
}

progress_reset() {
  local id="$1"
  local tmp; tmp="$(mktemp)"
  grep -vP "^$id\t" "$LAB_PROGRESS_FILE" > "$tmp" 2>/dev/null || true
  mv "$tmp" "$LAB_PROGRESS_FILE"
}

# --- environment detection -----------------------------------------------
in_container() {
  [ -f /.dockerenv ] && return 0
  grep -qE '/docker|/podman' /proc/1/cgroup 2>/dev/null && return 0
  [ -n "${container:-}" ] && return 0
  return 1
}
