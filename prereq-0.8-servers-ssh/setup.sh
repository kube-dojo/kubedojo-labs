#!/bin/bash
# Setup / reset for prereq-0.8-servers-ssh. Idempotent: safe to re-run as reset.
# Starts a DEDICATED lab sshd on port 2222 with its own log — never touches a
# platform sshd on port 22 and never uses systemctl.
set -u
export DEBIAN_FRONTEND=noninteractive
if [ ! -x /usr/sbin/sshd ]; then
  apt-get update -qq >/dev/null 2>&1 || true
  apt-get install -y -qq openssh-server >/dev/null 2>&1
fi
ssh-keygen -A >/dev/null 2>&1
mkdir -p /run/sshd
# Stop any previous lab sshd, reset evidence and lab artifacts.
if [ -f /run/kd-sshd.pid ]; then
  kill "$(cat /run/kd-sshd.pid)" 2>/dev/null || true
  sleep 1
  rm -f /run/kd-sshd.pid
fi
rm -rf /tmp/kd-ssh
mkdir -p /tmp/kd-ssh
chmod 1777 /tmp/kd-ssh
: > /var/log/kd-sshd.log
# Remove only lab-created keys/entries (marker comment "kd-lab"), never learner defaults.
for h in /root /home/*; do
  [ -d "$h/.ssh" ] || continue
  rm -f "$h/.ssh/kd-lab-key" "$h/.ssh/kd-lab-key.pub"
  [ -f "$h/.ssh/authorized_keys" ] && sed -i '/ kd-lab$/d' "$h/.ssh/authorized_keys"
  [ -f "$h/.ssh/known_hosts" ] && ssh-keygen -R '[localhost]:2222' -f "$h/.ssh/known_hosts" >/dev/null 2>&1
done
# Accounts created without a password are "locked" ('!'), which sshd with
# UsePAM=no refuses even for key logins. '*' keeps password login impossible
# while allowing key auth. Only touch never-had-a-password login accounts.
for u in $(awk -F: '$7 ~ /(bash|sh)$/ && ($3 >= 1000 || $1 == "root") {print $1}' /etc/passwd); do
  p=$(awk -F: -v u="$u" '$1==u{print $2}' /etc/shadow)
  if [ "$p" = "!" ] || [ "$p" = "!!" ]; then
    usermod -p '*' "$u" 2>/dev/null || true
  fi
done
/usr/sbin/sshd -p 2222 \
  -o PidFile=/run/kd-sshd.pid \
  -o PermitRootLogin=prohibit-password \
  -o PubkeyAuthentication=yes \
  -o UsePAM=no \
  -E /var/log/kd-sshd.log
echo "Setup complete."
