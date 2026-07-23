TITLE="Create a Custom systemd Service"
CATEGORY="sysadmin"
DIFFICULTY="intermediate"
ENVIRON="native"
DESCRIPTION="A small internal tool needs to run continuously in the
background and restart automatically if it crashes. It should be
managed the proper way — as a systemd unit — not with a stray nohup
process."
OBJECTIVE="Create a systemd unit file at
/etc/systemd/system/labdemo.service that:
  1. Has Description set to something descriptive
  2. Runs ExecStart=/usr/bin/sleep infinity
  3. Has Restart=on-failure
  4. Is in the [Install] section with WantedBy=multi-user.target
Then reload systemd, enable, and start the service so it is active.
Run 'lab check 02-sysadmin/004-systemd-service' when done."
