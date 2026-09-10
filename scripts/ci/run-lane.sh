#!/bin/bash
# Runs ONE scenario lane inside the booted harness container (as root).
# Expects: /scenario mounted read-only, TEST_USER env var (root|ubuntu).
set -u

TEST_USER="${TEST_USER:?TEST_USER must be root or ubuntu}"

# securityfs: privileged containers can mount it; needed by LSM scenarios
# (aa-status, /sys/kernel/security/lsm). Host kernel decides which LSMs
# actually exist — scenarios must handle absence honestly themselves.
mountpoint -q /sys/kernel/security 2>/dev/null || \
  mount -t securityfs securityfs /sys/kernel/security 2>/dev/null || true

if [ "$TEST_USER" = "ubuntu" ] && ! id ubuntu &>/dev/null; then
  useradd -m -s /bin/bash ubuntu
  echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-ubuntu-lab
  chmod 0440 /etc/sudoers.d/90-ubuntu-lab
fi

# Killercoda runs the intro background script as root before the learner
# gets a shell.
SETUP_SCRIPT=$(python3 -c "import json; d=json.load(open('/scenario/index.json')); print(d.get('details', {}).get('intro', {}).get('background', ''))" 2>/dev/null)
if [ -n "$SETUP_SCRIPT" ] && [ -f "/scenario/$SETUP_SCRIPT" ]; then
  echo "      [INFO] Running setup: $SETUP_SCRIPT"
  bash "/scenario/$SETUP_SCRIPT" > /tmp/setup.log 2>&1 || {
    echo "      [WARN] setup exited non-zero (see below)"; tail -5 /tmp/setup.log
  }
fi

exec python3 /opt/harness/run-steps.py
