#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: service-ip.txt contains a valid IP
if [ -f $USER_HOME/service-ip.txt ]; then
  IP=$(cat $USER_HOME/service-ip.txt)
  echo "$IP" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' && exit 0
fi
exit 1
