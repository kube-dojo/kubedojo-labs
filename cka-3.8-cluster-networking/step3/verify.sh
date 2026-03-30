#!/bin/bash
# Verify: iptables-rules.txt exists and contains data
[ -f /root/iptables-rules.txt ] && [ -s /root/iptables-rules.txt ] && exit 0 || exit 1
