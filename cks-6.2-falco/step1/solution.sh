#!/bin/bash
# Try to install Falco
{
  curl -fsSL https://falco.org/repo/falcosecurity-packages.asc | gpg --dearmor -o /usr/share/keyrings/falco-archive-keyring.gpg 2>/dev/null
  echo "deb [signed-by=/usr/share/keyrings/falco-archive-keyring.gpg] https://download.falco.org/packages/deb stable main" | tee /etc/apt/sources.list.d/falcosecurity.list
  apt-get update -qq && apt-get install -y falco
} 2>/dev/null || {
  echo "Falco installation failed — creating config manually"
  mkdir -p /etc/falco
}

systemctl status falco > /root/falco-status.txt 2>&1 || echo "Falco not running (installation may have failed)" > /root/falco-status.txt

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
# Falco Default Rules (sample — installation may have failed)
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
