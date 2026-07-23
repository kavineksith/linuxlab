TITLE="Triage a Crash-Looping Service with journalctl"
CATEGORY="systemd-deep"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="labcrasher.service has been deployed and is stuck in a
restart loop. Instead of guessing, use the journal — systemd's unified
log — to find the exact error message it's dying on."
OBJECTIVE="labcrasher.service is running (or trying to). Use journalctl
to find the specific error line it logs before each crash, and write
that EXACT line of output (just that one line) into answer.txt in the
workspace root. Do not fix the service — this task is about diagnosis.
Hint: journalctl -u labcrasher.service --no-pager
Run 'lab check 07-systemd-deep/004-journal-triage' when done."
