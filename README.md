# linuxlab

[![CI](https://github.com/kavineksith/linuxlab/actions/workflows/ci.yml/badge.svg)](https://github.com/kavineksith/linuxlab/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
![Tasks](https://img.shields.io/badge/tasks-43-blue)
![Bash](https://img.shields.io/badge/shell-bash-4EAA25?logo=gnubash&logoColor=white)

A hands-on Linux practice lab: realistic scenario tasks, an automated
`lab check` grader, progressive hints, and progress tracking — usable
either as a **container** (Podman or Docker) or installed **natively**
on a Debian-based host (Debian, Ubuntu, Linux Mint).

- [What this is](#what-this-is)
- [Curriculum & learning path](#curriculum--learning-path)
- [Disclaimer](#disclaimer)
- [Getting the code](#getting-the-code)
- [Option A: Run in a container](#option-a-run-in-a-container)
  - [Installing Docker](#installing-docker)
  - [Installing Podman](#installing-podman)
  - [Build & run](#build--run)
  - [Using Compose](#using-compose)
- [Option B: Native install](#option-b-native-install-debianubuntumint)
- [Using the `lab` CLI](#using-the-lab-cli)
- [What's included](#whats-included)
- [Adding your own tasks](#adding-your-own-tasks)
- [How it works](#how-it-works)
- [License](#license)

## What this is

`linuxlab` is a self-contained set of shell scripts: a small CLI (`lab`)
plus a directory of tasks. Each task is a realistic scenario (a broken
permission, a runaway process, a missing sudoers rule, ...) with an
automated checker and a few progressive hints. Nothing here phones home
or needs an account — it's just files on disk.

## Curriculum & learning path

New to this project? Start with [`CURRICULUM.md`](./CURRICULUM.md) — it
lays out a recommended order through all 43 tasks, explains what each
category is actually used for on the job, and maps it to real IT career
tracks (sysadmin, DevOps/SRE, security, cloud). This README covers
installing and running the lab; CURRICULUM.md covers _why_ and _in
what order_.

## Disclaimer

This project is provided **as-is, for personal learning and training
purposes only**, with no warranty of any kind (see [License](#license)).
A few things worth knowing before you use it:

- **Several tasks intentionally modify real system state** — creating
  users and groups, editing sudoers, writing crontabs, changing file
  permissions, creating loop-device filesystems and LVM volumes,
  loading AppArmor profiles, adding audit rules, and (in the
  `containers` category) running real Docker/Podman containers on your
  host. Run this in the provided container, a disposable virtual
  machine, or a lab machine you don't mind resetting. **Do not run the
  native installer (`install.sh`) on a production system or your
  primary daily-use machine.**
- The `storage-lvm` tasks use file-backed loop devices specifically so
  nothing touches your real disks or partitions — but they still
  require real privileged access to the kernel's block/LVM/loop
  subsystems, which is why they're marked `native` and generally won't
  work inside an unprivileged container.
- Some tasks use `NOPASSWD` sudoers rules and passwordless container
  accounts (`labuser` / `labuser`) purely to make the lab convenient to
  use. These are deliberately **insecure defaults for a throwaway
  learning environment** — never reuse them anywhere that matters.
- The author(s) are not responsible for any data loss, system breakage,
  or security exposure resulting from running these scripts. Read
  `meta.sh` and `check.sh` for a task before running it if you want to
  know exactly what it does.
- This is an independent educational project. It is not affiliated
  with, endorsed by, or sponsored by Canonical, Debian, Docker Inc., or
  Red Hat/Podman.

## Getting the code

Clone the repository with git:

```bash
git clone https://github.com/kavineksith/linuxlab.git
cd linuxlab
```

No `git`? Install it first:

```bash
# Debian / Ubuntu / Mint
sudo apt-get update && sudo apt-get install -y git
```

## Option A: Run in a container

This is the recommended way to try linuxlab — it's fully disposable and
never touches your host system. You need **either Docker or Podman**;
you don't need both. If you already have one installed, skip to
[Build & run](#build--run).

### Installing Docker

Debian/Ubuntu ship an outdated `docker.io` package in their default
repos, so the official Docker install script is the most reliable way
to get a current CLI + engine:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker "$USER"   # lets you run docker without sudo
newgrp docker                     # or just log out and back in
```

Verify it worked:

```bash
docker --version
docker compose version   # Compose v2 is bundled with recent installs
```

If you'd rather add Docker's apt repository manually instead of the
convenience script, follow the official steps at
<https://docs.docker.com/engine/install/ubuntu/> (or `/debian/`) —
the short version is:

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

### Installing Podman

Debian 12+, Ubuntu 22.04+, and recent Mint releases carry a reasonably
current Podman in their default repos:

```bash
sudo apt-get update
sudo apt-get install -y podman
```

Verify:

```bash
podman --version
```

Podman Compose (optional, only needed for the `podman compose` /
`podman-compose` command) isn't always in the default repos:

```bash
sudo apt-get install -y podman-compose
# if that package isn't available, install via pip instead:
python3 -m pip install --user podman-compose
```

If your distro's Podman is too old (check with `podman --version` — aim
for 4.x or newer), the upstream install matrix has current instructions
per distro: <https://podman.io/docs/installation>.

### Build & run

Once you have Docker **or** Podman installed:

```bash
# Docker
docker build -t linuxlab -f Containerfile .
docker run -it --rm -v linuxlab-home:/home/labuser linuxlab

# Podman (same syntax — Podman's CLI mirrors Docker's)
podman build -t linuxlab -f Containerfile .
podman run -it --rm -v linuxlab-home:/home/labuser linuxlab
```

You land in a bash shell as `labuser` with the `lab` command already on
your PATH. The `-v linuxlab-home:/home/labuser` volume keeps your
progress and home directory across container restarts; drop that flag
for a fully disposable, no-trace session. Run `lab doctor` right away —
it'll flag the categories (LVM, AppArmor, auditd, systemd-deep,
containers) that need a real VM instead of this default unprivileged
container.

### Using Compose

A `compose.yaml` is included so you can start the lab with one command
instead of remembering the build/run flags:

```bash
# Docker
docker compose run --rm linuxlab

# Podman
podman compose run --rm linuxlab
# or, with the standalone podman-compose tool:
podman-compose run --rm linuxlab
```

`run --rm` gives you a fresh interactive session and removes the
container on exit; the named volume still persists your progress
between runs. If you'd rather have a long-lived container you can
re-attach to, use `docker compose up -d` then
`docker compose exec linuxlab bash -l`.

## Option B: Native install (Debian/Ubuntu/Mint)

Skip this if you're using the container. This installs directly onto
your Linux system — read the [disclaimer](#disclaimer) first.

```bash
sudo ./install.sh
lab doctor
lab list
```

This installs a handful of packages (`cron`, `sudo`, `ufw`,
`openssh-server`, standard coreutils, etc.), copies the project to
`/opt/linuxlab`, and symlinks the `lab` command into `/usr/local/bin`.
Safe to re-run; it just overwrites `/opt/linuxlab` with the current
copy.

## Using the `lab` CLI

Before diving into tasks — especially the LVM, systemd-deep,
security-mac, or containers tracks — run the environment doctor once to
see what's actually available:

```
lab doctor
```

It checks OS, container-vs-native status, sudo access, systemd,
loop devices/LVM, AppArmor, auditd, container engines, and all the
core tools each category needs — and tells you exactly which tasks
each missing piece affects, instead of you discovering it mid-task.

```
lab list                      # see all tasks + your progress
lab doctor                    # check environment prerequisites
lab show <task-id>            # read the scenario and objective
lab start <task-id>           # set up the task's starting state
lab check <task-id>           # grade your work
lab hint <task-id>            # reveal the next hint
lab reset <task-id|--all>     # reset progress and try again
lab progress                  # overall progress bar
lab next                      # jump to your next incomplete task
```

Task IDs look like `01-fundamentals/001-file-permissions` — tab-complete
isn't set up, so `lab list` is your friend for finding exact IDs.

## What's included

**43 tasks across 11 categories**, beginner through advanced — see
[`CURRICULUM.md`](./CURRICULUM.md) for a recommended learning path, the
"why this matters for your career" case for each area, and which real
IT job roles lean on which skills.

| #   | Category           | Tasks | Focus                                                                                      |
| --- | ------------------ | ----- | ------------------------------------------------------------------------------------------ |
| 01  | `fundamentals`     | 6     | permissions, processes, find, sed, tar/gzip, shell scripting                               |
| 02  | `sysadmin`         | 6     | users/groups, log analysis, apt, systemd basics, disk usage, service troubleshooting       |
| 03  | `security`         | 6     | cron, sudoers, SSH hardening, ufw firewall, file integrity, password aging                 |
| 04  | `networking`       | 4     | IP addressing, DNS, port identification, SSH key auth                                      |
| 05  | `storage`          | 3     | log cleanup by age, logrotate, backup scripting                                            |
| 06  | `storage-lvm`      | 4     | loop devices, LVM (PV/VG/LV), online resize, fstab persistence                             |
| 07  | `systemd-deep`     | 4     | timers (cron replacement), resource limits (cgroups), unit dependencies, journalctl triage |
| 08  | `security-mac`     | 3     | AppArmor enforce mode, writing AppArmor profiles, auditd file watches                      |
| 09  | `backups-recovery` | 3     | rsync mirroring, restore + checksum verification, automated backup timers                  |
| 10  | `containers`       | 3     | run/inspect, build a custom image, container-to-container networking                       |
| 11  | `capstone`         | 1     | multi-skill "sick server" triage combining process, permissions, and disk skills           |

Each task is self-contained: a scenario, an objective, an automated
checker, and 2-4 progressive hints (vague → exact command).

Tasks tagged `native` in `lab show` (systemd, firewall, LVM/loop
devices, AppArmor, auditd, network interface changes, containers-on-host)
need a real host/VM with the right kernel privileges — the default
container has no init system, no NET_ADMIN, and no access to the host's
loop/audit/apparmor subsystems. Everything else works in both
environments. Tasks that reach the internet (installing a package,
pulling a container image) need outbound network access.

## Adding your own tasks

Copy `tasks/_template/000-template/` into `tasks/<NN-category>/<NNN-slug>/`
and fill in the four files:

- **meta.sh** — title, category, difficulty, environment, description, objective
- **setup.sh** _(optional)_ — creates the starting "broken" state
- **check.sh** — validates the learner's work; exit 0 = pass
- **hints.txt** — one hint per line, revealed progressively

`lab list` picks up new tasks automatically — no registration step needed.

## How it works

- `bin/lab` is the CLI entry point; `lib/lab-core.sh` has the shared logic.
- Progress is stored per-user in `~/.local/share/linuxlab/progress.tsv`
  (not shared system-wide), so multiple learners on one host don't collide.
- Each task gets its own scratch directory under `~/linuxlab-workspace/`,
  used as the working directory for `setup.sh` and `check.sh`.

## License

MIT License — see [`LICENSE`](./LICENSE). In short: you can use, copy,
modify, and redistribute this freely, including commercially, as long
as you keep the copyright notice. It comes with **no warranty** — see
the [disclaimer](#disclaimer) above for the practical implications of
that for a project that edits system users, sudoers, and cron.
