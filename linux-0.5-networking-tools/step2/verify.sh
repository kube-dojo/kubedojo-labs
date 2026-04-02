#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/google-ip.txt contains an IP address
if [ ! -f $USER_HOME/google-ip.txt ]; then
  echo "$USER_HOME/google-ip.txt does not exist"
  exit 1
fi

ip=$(cat $USER_HOME/google-ip.txt | tr -d '[:space:]')
if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Resolved google.com to: $ip"
  exit 0
else
  echo "File should contain an IP address, got: '$ip'"
  exit 1
fi
