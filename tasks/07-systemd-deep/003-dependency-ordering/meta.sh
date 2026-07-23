TITLE="Make One Service Depend on Another"
CATEGORY="systemd-deep"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="A frontend service is crash-looping because it starts
before its backend is ready. Rather than adding a sleep/retry hack, the
correct fix is telling systemd about the dependency explicitly."
OBJECTIVE="Create two service units:
  1. /etc/systemd/system/labbackend.service — ExecStart=/usr/bin/sleep infinity
  2. /etc/systemd/system/labfrontend.service — ExecStart=/usr/bin/sleep infinity,
     with 'After=labbackend.service' AND 'Requires=labbackend.service'
     in its [Unit] section, so it always starts after (and requires) the backend.
Enable and start labfrontend.service (systemd will pull in the backend
automatically because of Requires=), and confirm both end up active.
Run 'lab check 07-systemd-deep/003-dependency-ordering' when done."
