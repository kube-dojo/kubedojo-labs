#!/bin/bash
# Solution: Configure sudo for developer (apt only)
echo 'developer ALL=(ALL) /usr/bin/apt' > /etc/sudoers.d/developer
chmod 440 /etc/sudoers.d/developer
echo 'developer ALL=(ALL) /usr/bin/apt' > /root/sudo-rule.txt
cat /root/sudo-rule.txt
