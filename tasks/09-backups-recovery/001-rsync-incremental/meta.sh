TITLE="Mirror a Directory with rsync"
CATEGORY="backups-recovery"
DIFFICULTY="intermediate"
ENVIRON="both"
DESCRIPTION="Copying entire directories with cp every time is slow and
wasteful for backups. rsync only transfers what actually changed —
this is the tool behind most real-world backup scripts."
OBJECTIVE="Use rsync to mirror source/ into mirror/ inside the
workspace, such that mirror/ ends up byte-for-byte identical to
source/, including removing any files in mirror/ that no longer exist
in source/ (i.e. a true mirror, not just an additive copy).
Run 'lab check 09-backups-recovery/001-rsync-incremental' when done."
