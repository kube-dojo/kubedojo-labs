# Disk Partitioning and Block Devices

## lsblk — List Block Devices

```bash
# Simple listing
lsblk

# Detailed with filesystem info
lsblk -f

# Output specific columns
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
```

## blkid — Block Device Attributes

```bash
blkid
```

Shows UUID, filesystem type, and labels for each device.

## fdisk — Partition Table

```bash
# List partitions (read-only)
fdisk -l
```

## Your Task

List all block devices with their name, size, type, and mount point. Save to `/root/block-devices.txt`.

```bash
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT > /root/block-devices.txt
```
