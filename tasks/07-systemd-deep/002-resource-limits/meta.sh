TITLE="Cap a Service's Resource Usage"
CATEGORY="systemd-deep"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="A misbehaving service once ate all the RAM on a box and
took down everything else with it. Ops policy now requires resource
limits on every custom service, enforced via systemd's built-in cgroup
integration — no separate cgroup tooling needed."
OBJECTIVE="Edit /etc/systemd/system/labdemo.service (created in the
earlier systemd-service task — create it first if missing) to add,
inside the [Service] section:
  MemoryMax=100M
  CPUQuota=50%
Reload systemd and restart the service, then confirm the running unit
actually has these limits applied (not just written in the file) using
'systemctl show'.
Run 'lab check 07-systemd-deep/002-resource-limits' when done."
