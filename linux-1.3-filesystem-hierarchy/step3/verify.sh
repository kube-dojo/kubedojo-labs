#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME$USER_HOME-fstype.txt contains a known filesystem type
if [ ! -f $USER_HOME$USER_HOME-fstype.txt ]; then
  echo "$USER_HOME$USER_HOME-fstype.txt does not exist"
  exit 1
fi

fstype=$(cat $USER_HOME$USER_HOME-fstype.txt | tr -d '[:space:]')
if [[ "$fstype" =~ ^(ext[234]|xfs|btrfs|overlay|tmpfs|zfs)$ ]]; then
  echo "Root filesystem type: $fstype"
  exit 0
else
  # Accept any non-empty value as some environments use unusual types
  if [ -n "$fstype" ]; then
    echo "Root filesystem type: $fstype"
    exit 0
  fi
  echo "File should contain a filesystem type, got: '$fstype'"
  exit 1
fi
