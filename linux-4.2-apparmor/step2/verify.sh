#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify AppArmor profile for curl exists

if [ ! -f /etc/apparmor.d/usr.bin.curl ]; then
  echo "FAIL: /etc/apparmor.d/usr.bin.curl does not exist"
  exit 1
fi

if grep -q "/usr/bin/curl" /etc/apparmor.d/usr.bin.curl; then
  echo "PASS: AppArmor profile for curl exists"
  exit 0
else
  echo "FAIL: Profile file does not reference /usr/bin/curl"
  exit 1
fi
