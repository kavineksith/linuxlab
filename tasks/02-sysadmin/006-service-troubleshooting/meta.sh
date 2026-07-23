TITLE="Fix the Failing webapp Service"
CATEGORY="sysadmin"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="The on-call engineer reports that 'webapp.service' keeps
failing to start after a config change someone pushed. You need to
diagnose it using systemd's own tools and fix the root cause."
OBJECTIVE="Diagnose why webapp.service fails to start (systemctl status,
journalctl -u webapp are your friends), fix the underlying problem in
/etc/systemd/system/webapp.service, then reload systemd and get the
service to an active (running) state.
Run 'lab check 02-sysadmin/006-service-troubleshooting' when done."
