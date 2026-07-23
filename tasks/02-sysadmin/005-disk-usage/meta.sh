TITLE="Hunt Down the Disk Hog"
CATEGORY="sysadmin"
DIFFICULTY="intermediate"
ENVIRON="both"
DESCRIPTION="A disk-space alert fired for this box. Somewhere under the
workspace directory tree, one file is eating far more space than
everything else combined."
OBJECTIVE="Find the single largest file (by size) anywhere under the
workspace directory (including subdirectories), and write its relative
path into answer.txt in the workspace root.
Hint tools: du, find, sort.
Run 'lab check 02-sysadmin/005-disk-usage' when done."
