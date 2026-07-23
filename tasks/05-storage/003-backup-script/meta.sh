TITLE="Write a Reusable Backup Script"
CATEGORY="storage"
DIFFICULTY="advanced"
ENVIRON="both"
DESCRIPTION="This is the capstone task — it pulls together scripting,
archiving, and file handling. Ops wants a reusable backup script they
can point at any source directory and destination."
OBJECTIVE="Create an executable script named backup.sh in the workspace
directory. It must accept two arguments: backup.sh <source_dir> <dest_dir>
and:
  1. Create a gzip-compressed tar archive of <source_dir>'s contents
  2. Name the archive backup-<timestamp>.tar.gz, where <timestamp> is
     any sortable date/time string (e.g. YYYYMMDD-HHMMSS)
  3. Write the archive into <dest_dir>
The checker will run it as './backup.sh source dest' against a real
sample source/ directory that already exists in your workspace.
Run 'lab check 05-storage/003-backup-script' when done."
