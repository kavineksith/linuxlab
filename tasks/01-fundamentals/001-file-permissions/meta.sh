TITLE="Fix the Leaky Secrets File"
CATEGORY="fundamentals"
DIFFICULTY="beginner"
ENVIRON="both"
DESCRIPTION="A script dropped a file called secrets.txt in your workspace with
world-readable, world-writable permissions (666) and owned by the wrong
user. That's a real audit finding — any user on the box can read or
tamper with it."
OBJECTIVE="In the task workspace directory:
  1. Change secrets.txt permissions to exactly 640 (owner rw, group r, others none).
  2. The file's group must be 'labgroup' (it will be created for you).
Run 'lab check 01-fundamentals/001-file-permissions' when done."
