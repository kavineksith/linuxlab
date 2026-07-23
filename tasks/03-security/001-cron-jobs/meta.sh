TITLE="Schedule the Nightly Cleanup"
CATEGORY="security"
DIFFICULTY="intermediate"
ENVIRON="native"
DESCRIPTION="Ops wants a cron job for the current user that removes files
older than 7 days from /tmp/labcleanup every night at 2:30 AM, and logs
that it ran."
OBJECTIVE="Add a crontab entry for the current user that runs at 2:30 AM
every day and executes exactly:
  find /tmp/labcleanup -type f -mtime +7 -delete
Run 'lab check 03-security/001-cron-jobs' when done."
