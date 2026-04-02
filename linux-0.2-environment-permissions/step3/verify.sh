#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/suid-bins.txt exists and contains known SUID binaries
if [ ! -f $USER_HOME/suid-bins.txt ]; then
  echo "$USER_HOME/suid-bins.txt does not exist"
  exit 1
fi

if grep -q "passwd" $USER_HOME/suid-bins.txt; then
  lines=$(wc -l < $USER_HOME/suid-bins.txt | tr -d '[:space:]')
  echo "Found $lines SUID binaries including passwd. Good security audit!"
  exit 0
else
  echo "Expected to find /usr/bin/passwd in the list"
  exit 1
fi
