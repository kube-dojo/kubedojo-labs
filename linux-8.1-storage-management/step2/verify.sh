#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Check if tmpfs is mounted, or if directory exists (Docker fallback)
if mount | grep -q "/mnt/ramdisk"; then
  echo "PASS: /mnt/ramdisk is mounted as tmpfs"
  exit 0
elif [ -d /mnt/ramdisk ] && [ -f /mnt/ramdisk/.mounted ]; then
  echo "PASS: /mnt/ramdisk created (Docker environment — tmpfs simulated)"
  exit 0
else
  echo "FAIL: /mnt/ramdisk is not mounted or created"
  exit 1
fi
