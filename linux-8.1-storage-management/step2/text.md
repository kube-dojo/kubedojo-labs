# Filesystem Operations

## tmpfs — RAM-based Filesystem

`tmpfs` is a filesystem stored in memory. It is fast and temporary — data is lost on reboot.

```bash
# Create mount point
mkdir -p /mnt/ramdisk

# Mount tmpfs with size limit
mount -t tmpfs -o size=50M tmpfs /mnt/ramdisk

# Verify
df -h /mnt/ramdisk
mount | grep ramdisk
```

## Common Filesystem Commands

| Command | Purpose |
|---------|---------|
| `mkfs.ext4 /dev/sdX` | Create ext4 filesystem |
| `mount /dev/sdX /mnt` | Mount a device |
| `umount /mnt` | Unmount |
| `df -h` | Show mounted filesystem usage |

## Your Task

1. Create the directory `/mnt/ramdisk`
2. Mount a tmpfs filesystem there with a 50MB size limit
3. Verify it is mounted with `mount` or `df`

```bash
mkdir -p /mnt/ramdisk
mount -t tmpfs -o size=50M tmpfs /mnt/ramdisk
```
