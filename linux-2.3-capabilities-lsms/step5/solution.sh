#!/bin/bash
grep Seccomp: /proc/$$/status > /tmp/kd-caps/seccomp-mode.txt
sudo systemd-run --wait --quiet -p SystemCallFilter='~mkdir mkdirat' bash -c 'mkdir /tmp/kd-caps/blocked-dir'; echo "exit=$?" > /tmp/kd-caps/seccomp-blocked.txt
sudo systemd-run --wait --quiet bash -c 'mkdir -p /tmp/kd-caps/allowed-dir'
cat /tmp/kd-caps/seccomp-mode.txt /tmp/kd-caps/seccomp-blocked.txt
