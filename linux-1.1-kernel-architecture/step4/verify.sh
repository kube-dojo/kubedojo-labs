#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/dmesg-tail.txt exists and has content
if [ ! -f $USER_HOME/dmesg-tail.txt ]; then
  echo "$USER_HOME/dmesg-tail.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/dmesg-tail.txt ]; then
  echo "$USER_HOME/dmesg-tail.txt is empty"
  exit 1
fi

lines=$(wc -l < $USER_HOME/dmesg-tail.txt | tr -d '[:space:]')
echo "Captured $lines lines of kernel messages."
exit 0
