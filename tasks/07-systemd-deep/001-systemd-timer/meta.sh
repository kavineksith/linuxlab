TITLE="Replace Cron with a systemd Timer"
CATEGORY="systemd-deep"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="Modern Debian/Ubuntu systems favor systemd timers over
cron for scheduled jobs — they integrate with logging, dependencies,
and 'systemctl status' the same way regular services do."
OBJECTIVE="1. Create a oneshot service unit /etc/systemd/system/labjob.service
   whose ExecStart appends a line to /tmp/labjob.log (any command that
   does this is fine, e.g. ExecStart=/bin/bash -c 'echo run >> /tmp/labjob.log').
2. Create a matching timer unit /etc/systemd/system/labjob.timer with
   OnCalendar=daily and WantedBy=timers.target.
3. Enable and start the TIMER (not the service directly).
4. Confirm it's scheduled with 'systemctl list-timers'.
Run 'lab check 07-systemd-deep/001-systemd-timer' when done."
