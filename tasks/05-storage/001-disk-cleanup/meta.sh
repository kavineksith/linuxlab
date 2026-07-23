TITLE="Prune Stale Logs, Keep the Fresh Ones"
CATEGORY="storage"
DIFFICULTY="intermediate"
ENVIRON="both"
DESCRIPTION="The old_logs/ directory is full of rotated log files. Ops
wants anything older than 14 days purged to reclaim space — but recent
logs must be left alone in case they're needed for an active
investigation."
OBJECTIVE="Inside the workspace, delete only the *.log files under
old_logs/ that are OLDER than 14 days, while leaving newer *.log files
in place. Do not delete the old_logs/ directory itself.
Run 'lab check 05-storage/001-disk-cleanup' when done."
