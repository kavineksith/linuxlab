# Contributing to linuxlab

Thanks for considering a contribution — task packs are the lifeblood of
this project, and it's designed specifically so adding one doesn't
require touching any core code.

## Adding a new task (the main way to contribute)

1. Copy `tasks/_template/000-template/` to
   `tasks/<NN-category>/<NNN-slug>/` (create a new category folder if
   yours doesn't fit an existing one).
2. Fill in the four files:
   - **meta.sh** — `TITLE`, `CATEGORY`, `DIFFICULTY` (beginner/intermediate/advanced),
     `ENVIRON` (`container`/`native`/`both`), `DESCRIPTION`, `OBJECTIVE`.
   - **setup.sh** *(optional)* — creates the starting "broken" scenario.
     Runs with cwd = the task's isolated workspace directory.
   - **check.sh** — validates the learner's work. Exit 0 = pass. Print a
     specific, actionable reason on failure — that text is shown
     directly to the learner, so vague messages hurt the experience.
   - **hints.txt** — one hint per line, ordered vague → exact. Aim for
     3-4: a nudge, a narrower nudge, and the full command.
3. Run `bash -n setup.sh check.sh` on your new files before opening a PR
   — a syntax error in a task script fails silently for the learner in
   confusing ways.
4. Test the full cycle yourself: `lab start`, deliberately leave it
   broken and confirm `lab check` fails with a useful message, fix it,
   confirm `lab check` passes.
5. If your task needs privileges/kernel features the default container
   doesn't have (systemd, LVM, AppArmor, auditd, real network changes),
   set `ENVIRON="native"` and make sure `check.sh` fails with a clear
   "this needs a native host" message rather than a cryptic error when
   the required tool/capability is missing.

## Task design guidelines

- **One clear, checkable objective per task.** If you're tempted to
  check five unrelated things, it's probably multiple tasks (or a
  capstone, if that's intentional).
- **Realistic framing.** Tasks read better as "a ticket from a
  teammate" than as a dry command tutorial — see existing tasks for
  tone.
- **Deterministic checks.** Avoid checks that depend on timing, random
  ordering, or exact wall-clock values where avoidable — flaky checks
  are worse than no checks.
- **Idempotent setup.sh.** It should be safe to run `lab start` on the
  same task twice without leaving cruft (clean up old state at the top
  of the script).
- **No destructive defaults.** Never have `setup.sh` or `check.sh` act
  outside the task's own workspace or clearly-scoped system resources
  (a named user, a named service, a specific file) without a strong
  reason — see the [disclaimer in the README](./README.md#disclaimer)
  for why this matters.

## Other ways to contribute

- **Bug reports on existing tasks**: open an issue with the task ID,
  what you ran, and the exact output of `lab check`.
- **`lab doctor` improvements**: additional environment checks (new
  distros, new prerequisite tools) are welcome — see `lib/lab-doctor.sh`.
- **Core CLI improvements** (`bin/lab`, `lib/lab-core.sh`): please open
  an issue to discuss non-trivial changes before a large PR, since the
  CLI's simplicity (no external dependencies beyond coreutils) is a
  deliberate design choice.
- **Documentation**: fixes to README.md / CURRICULUM.md are always
  welcome, especially corrections to distro-specific package names or
  version-specific command output.

## Pull request checklist

- [ ] `bash -n` passes on every shell script you touched
- [ ] New tasks include all four required files (meta.sh, check.sh,
      hints.txt; setup.sh if applicable)
- [ ] You ran the task yourself end-to-end (fail → fix → pass)
- [ ] `ENVIRON` is set accurately for what the task actually needs
- [ ] No hardcoded paths outside the task's workspace or a clearly
      task-scoped system resource

## Code of Conduct

This project follows the [Contributor Covenant](./CODE_OF_CONDUCT.md).
Be respectful, assume good faith, and remember most contributors here
are learning too.
