TITLE="Restore from Backup and Verify Integrity"
CATEGORY="backups-recovery"
DIFFICULTY="intermediate"
ENVIRON="both"
DESCRIPTION="A disaster-recovery drill: a backup archive exists, but
nobody has actually tried restoring it recently. An untested backup is
not a backup — this task proves it actually works."
OBJECTIVE="1. Extract db_backup.tar.gz (in the workspace) into a new
   directory named restored/.
2. Verify every restored file matches the checksums listed in
   db_backup.sha256 (also in the workspace).
3. Write the word 'VERIFIED' into answer.txt if and only if every file
   matches; otherwise investigate — the checker will independently
   re-verify regardless of what you write.
Run 'lab check 09-backups-recovery/002-restore-verification' when done."
