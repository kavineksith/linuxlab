TITLE="Find the Intruder in the Logs"
CATEGORY="sysadmin"
DIFFICULTY="intermediate"
ENVIRON="both"
DESCRIPTION="A sample auth log (auth.log) has been placed in your workspace.
It contains a mix of successful and failed SSH login attempts from many IP
addresses. Somewhere in there, one IP address made significantly more
failed attempts than any other — a brute-force pattern."
OBJECTIVE="Find the single IP address with the most 'Failed password'
lines in auth.log, and write ONLY that IP address (nothing else) into a
file named answer.txt in the same workspace directory.
Hint tools: grep, awk, sort, uniq -c.
Run 'lab check 02-sysadmin/002-log-analysis' when done."
