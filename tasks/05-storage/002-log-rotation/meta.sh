TITLE="Configure Log Rotation for a New App"
CATEGORY="storage"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="A new application logs to /var/log/labapp.log and nothing
is rotating it — left unchecked it will grow forever. Ops standard is
weekly rotation, keep 4 old copies, compress the old ones."
OBJECTIVE="Create a logrotate config at /etc/logrotate.d/labapp for
/var/log/labapp.log that:
  1. Rotates weekly
  2. Keeps 4 rotated copies (rotate 4)
  3. Compresses rotated logs (compress)
Validate it with 'sudo logrotate -d /etc/logrotate.d/labapp' (dry run —
should report no errors).
Run 'lab check 05-storage/002-log-rotation' when done."
