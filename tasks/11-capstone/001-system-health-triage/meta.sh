TITLE="Capstone: Triage a Sick Server"
CATEGORY="capstone"
DIFFICULTY="advanced"
ENVIRON="both"
DESCRIPTION="This is the final exam. On-call just paged you: a server
is misbehaving in three unrelated ways at once, and the ticket has no
other details. This task deliberately doesn't tell you exactly what's
wrong with each piece — that's the point. Use the skills from every
earlier category: process inspection, permissions, disk usage, and
log/text analysis."
OBJECTIVE="Inside the workspace directory, three things are broken.
Fix all three:
  1. A runaway process named 'lab_capstone_leak' is consuming CPU in
     the background — find it and stop it.
  2. A file at incident/app-output.log is world-writable (anyone can
     tamper with it) — fix its permissions to 640, owned by the
     current user's primary group.
  3. Somewhere under incident/data/ is a single file that is
     abnormally large compared to everything else, quietly filling
     the disk. Delete just that one oversized file (leave every other
     file untouched).
Run 'lab check 11-capstone/001-system-health-triage' to verify all
three are resolved."
