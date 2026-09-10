#!/bin/bash
cat /sys/kernel/security/lsm > /tmp/kd-caps/lsm.txt
sudo aa-status > /tmp/kd-caps/aa-status.txt 2>&1 || true
if grep -qw apparmor /tmp/kd-caps/lsm.txt; then echo yes > /tmp/kd-caps/apparmor-active.txt; else echo no > /tmp/kd-caps/apparmor-active.txt; fi
cat /tmp/kd-caps/lsm.txt /tmp/kd-caps/apparmor-active.txt
