TITLE="Make a Mount Survive a Reboot"
CATEGORY="storage-lvm"
DIFFICULTY="intermediate"
ENVIRON="native"
DESCRIPTION="Everything you mount manually with 'mount' disappears on
reboot. Production filesystems need an /etc/fstab entry — and it should
reference the filesystem by UUID, not a device path like /dev/loop0
that can change between boots."
OBJECTIVE="For the filesystem mounted at /mnt/labdisk (from the loop
filesystem task):
  1. Find its UUID with blkid.
  2. Add an entry to /etc/fstab that mounts it at /mnt/labdisk using
     its UUID (not the raw device path), filesystem type ext4, with
     'defaults' options.
  3. Verify the fstab entry is valid by running 'sudo mount -a' with no
     errors.
Run 'lab check 06-storage-lvm/004-fstab-persistence' when done."
