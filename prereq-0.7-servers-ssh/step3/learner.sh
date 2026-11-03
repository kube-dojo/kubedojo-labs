#!/bin/bash
# text.md:2. Inspect the configuration, then write only its configured/default port.
# expect-exit: 0
cat /etc/ssh/sshd_config
# expect-exit: 0
awk '/^[[:space:]]*Port[[:space:]]+/ {print $2; found=1; exit} END {if (!found) print 22}' /etc/ssh/sshd_config > ~/ssh-port.txt
