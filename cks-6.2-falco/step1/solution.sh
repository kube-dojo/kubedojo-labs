#!/bin/bash
FALCO_INSTALLED=false

# Try to install Falco
if command -v apt-get &>/dev/null; then
  {
    curl -fsSL https://falco.org/repo/falcosecurity-packages.asc 2>/dev/null | gpg --dearmor -o /usr/share/keyrings/falco-archive-keyring.gpg 2>/dev/null
    echo "deb [signed-by=/usr/share/keyrings/falco-archive-keyring.gpg] https://download.falco.org/packages/deb stable main" | tee /etc/apt/sources.list.d/falcosecurity.list
    apt-get update -qq && apt-get install -y falco
    FALCO_INSTALLED=true
  } 2>/dev/null || true
fi

mkdir -p /etc/falco

if [ "$FALCO_INSTALLED" = true ]; then
  systemctl status falco > /root/falco-status.txt 2>&1
else
  cat > /root/falco-status.txt << 'STATUS'
Falco not installed (kind cluster — no kernel module support).
In production, Falco would run as:
  - A DaemonSet with kernel module or eBPF probe
  - systemctl status falco would show: active (running)
  - Falco monitors syscalls and container events in real-time
STATUS
fi

cat > /root/falco-rules-paths.txt << 'PATHS'
/etc/falco/falco_rules.yaml — Default rules (do not edit)
/etc/falco/falco_rules.local.yaml — Custom rules (add your rules here)
/etc/falco/falco.yaml — Falco configuration
/etc/falco/rules.d/ — Additional rule files directory
PATHS

if [ -f /etc/falco/falco_rules.yaml ]; then
  head -50 /etc/falco/falco_rules.yaml > /root/default-rules-sample.txt
else
  cat > /root/default-rules-sample.txt << 'SAMPLE'
# Falco Default Rules (sample — Falco not installed in kind)
# These detect common security threats:
- rule: Terminal shell in container
  desc: Detect shell spawned in container
  condition: >
    spawned_process and container and
    proc.name in (bash, sh, zsh, csh, dash)
  output: >
    Shell spawned in container (user=%user.name container=%container.name
    shell=%proc.name parent=%proc.pname cmdline=%proc.cmdline)
  priority: WARNING

- rule: Read sensitive file
  desc: Detect reads of sensitive files
  condition: >
    open_read and container and
    fd.name in (/etc/shadow, /etc/passwd)
  output: >
    Sensitive file read in container (file=%fd.name container=%container.name)
  priority: WARNING
SAMPLE
fi
