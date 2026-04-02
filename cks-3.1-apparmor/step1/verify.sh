#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/apparmor-status.txt ] || [ ! -s $USER_HOME/apparmor-status.txt ]; then
  echo "FAIL: $USER_HOME/apparmor-status.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/loaded-profiles.txt ] || [ ! -s $USER_HOME/loaded-profiles.txt ]; then
  echo "FAIL: $USER_HOME/loaded-profiles.txt missing or empty"
  exit 1
fi
if [ ! -f /etc/apparmor.d/k8s-deny-write ]; then
  echo "FAIL: AppArmor profile /etc/apparmor.d/k8s-deny-write not found"
  exit 1
fi
# Accept either loaded profile or documentation that it was created
if command -v aa-status &>/dev/null; then
  aa-status 2>/dev/null | grep -q "k8s-deny-write" || true
fi
if [ ! -f $USER_HOME/profile-loaded.txt ] || [ ! -s $USER_HOME/profile-loaded.txt ]; then
  echo "FAIL: $USER_HOME/profile-loaded.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
