#!/bin/bash
sudo unshare --pid --fork --mount-proc bash -c 'readlink /proc/$$/ns/pid > /tmp/kd-ns/pid-inside.txt; ps -e --no-headers | wc -l > /tmp/kd-ns/pid-count.txt'
cat /tmp/kd-ns/pid-inside.txt /tmp/kd-ns/pid-count.txt
