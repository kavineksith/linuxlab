TITLE="Grow a Logical Volume Without Downtime"
CATEGORY="storage-lvm"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="datalv is filling up. The whole point of LVM is that you
can grow it live, without unmounting or losing data — that's the skill
this task drills. Requires completing the LVM basics task first (labvg
must already exist)."
OBJECTIVE="1. Extend the datalv logical volume by an additional 20M
   (to roughly 70M total).
2. Resize the ext4 filesystem on it to use the new space, ONLINE
   (without unmounting /mnt/labdata).
3. Confirm the filesystem now reports the larger size.
Run 'lab check 06-storage-lvm/003-extend-lv' when done."
