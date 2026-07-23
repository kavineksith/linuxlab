TITLE="Build Your First LVM Volume"
CATEGORY="storage-lvm"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="Real production storage almost never uses raw partitions
directly — LVM (Logical Volume Management) sits in between so storage
can be resized, snapshotted, and reorganized without downtime. Two loop
devices have been prepared for you to act as 'disks'."
OBJECTIVE="1. Create a physical volume (PV) on /dev/loop20 and /dev/loop21.
2. Create a volume group (VG) named labvg from both PVs.
3. Create a logical volume (LV) named datalv, size 50M, inside labvg.
4. Format datalv with ext4 and mount it at /mnt/labdata.
Run 'lab check 06-storage-lvm/002-lvm-basics' when done."
