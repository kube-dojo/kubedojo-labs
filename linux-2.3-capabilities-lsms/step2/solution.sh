#!/bin/bash
sudo gcc /opt/kd-caps/test-bind.c -o /opt/kd-caps/bind88
sudo -u nobody /opt/kd-caps/bind88 > /tmp/kd-caps/bind-before.txt 2>&1 || true
sudo setcap 'cap_net_bind_service=+ep' /opt/kd-caps/bind88
getcap /opt/kd-caps/bind88 > /tmp/kd-caps/getcap.txt
sudo -u nobody /opt/kd-caps/bind88 > /tmp/kd-caps/bind-after.txt 2>&1
cat /tmp/kd-caps/getcap.txt /tmp/kd-caps/bind-after.txt
