#!/bin/bash
cat > /root/boot-params.txt << 'EOF'
=== Current Boot Parameters ===
EOF

cat /proc/cmdline >> /root/boot-params.txt

cat >> /root/boot-params.txt << 'EOF'

=== Security Analysis ===
Checking for security-relevant parameters:

- nokaslr: Should NOT be present (disables ASLR)
- mitigations=off: Should NOT be present (disables CPU mitigations)
- module.sig_enforce: RECOMMENDED (enforces signed modules)
- lockdown=confidentiality: RECOMMENDED (restricts data-leaking features)
- init_on_alloc=1: RECOMMENDED (zeroes memory on allocation)

=== Recommendation ===
Add the following to GRUB_CMDLINE_LINUX in /etc/default/grub:
  init_on_alloc=1 slab_nomerge page_alloc.shuffle=1
These reduce the exploitability of use-after-free and heap-based vulnerabilities.
EOF
