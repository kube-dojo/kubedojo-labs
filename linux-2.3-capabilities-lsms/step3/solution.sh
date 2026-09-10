#!/bin/bash
sudo chown nobody /tmp/kd-caps/testfile
sudo capsh --drop=cap_chown -- -c 'chown root /tmp/kd-caps/testfile' 2> /tmp/kd-caps/drop-fail.txt || true
cat /tmp/kd-caps/drop-fail.txt
stat -c '%U' /tmp/kd-caps/testfile
