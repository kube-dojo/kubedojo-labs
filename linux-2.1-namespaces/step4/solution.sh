#!/bin/bash
readlink /proc/self/ns/net > /tmp/kd-ns/net-host.txt
sudo nsenter --net=/run/netns/lab-net readlink /proc/self/ns/net > /tmp/kd-ns/net-inside.txt
diff /tmp/kd-ns/net-host.txt /tmp/kd-ns/net-inside.txt || true
