TITLE="Automate Nightly Backups with a systemd Timer"
CATEGORY="backups-recovery"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="This ties together backup scripting and systemd timers:
a real backup job that runs on its own schedule, not one you have to
remember to trigger by hand."
OBJECTIVE="1. Write a script at /usr/local/bin/lab-nightly-backup.sh
   that runs: tar -czf /var/backups/labdata-$(date +%%Y%%m%%d).tar.gz -C /var/lab/data .
   (create /var/lab/data with at least one file in it if it doesn't exist,
   and /var/backups if missing). Make the script executable.
2. Create a oneshot service /etc/systemd/system/lab-nightly-backup.service
   that runs this script.
3. Create /etc/systemd/system/lab-nightly-backup.timer with
   OnCalendar=*-*-* 02:00:00 and WantedBy=timers.target.
4. Enable the timer, and manually trigger the service once
   ('systemctl start lab-nightly-backup.service') to confirm the
   script actually works end to end.
Run 'lab check 09-backups-recovery/003-scheduled-backup' when done."
