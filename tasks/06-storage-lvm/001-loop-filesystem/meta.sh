TITLE="Build a Filesystem from a Disk Image"
CATEGORY="storage-lvm"
DIFFICULTY="intermediate"
ENVIRON="native"
DESCRIPTION="Before touching real disks, every storage admin should
understand loop devices: ordinary files that the kernel can treat as
block devices. You'll build one from scratch, exactly like you would
practice partitioning without risking real hardware."
OBJECTIVE="1. Create a 100MB file at ~/labwork/disk.img (mkdir -p as needed).
2. Attach it as a loop device with losetup.
3. Format it with an ext4 filesystem.
4. Mount it at /mnt/labdisk.
Run 'lab check 06-storage-lvm/001-loop-filesystem' when done."
