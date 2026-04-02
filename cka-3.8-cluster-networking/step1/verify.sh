#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: pod-ips.txt exists with valid IPs
if [ -f $USER_HOME/pod-ips.txt ]; then
  LINE_COUNT=$(cat $USER_HOME/pod-ips.txt | grep -cE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')
  [ "$LINE_COUNT" -ge 3 ] && exit 0
fi
exit 1
