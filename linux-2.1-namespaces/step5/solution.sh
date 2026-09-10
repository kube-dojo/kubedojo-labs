#!/bin/bash
sudo unshare --mount --propagation private bash -c 'mkdir -p /tmp/kd-ns/mnt-demo && mount -t tmpfs -o size=1m tmpfs /tmp/kd-ns/mnt-demo && echo namespace-data > /tmp/kd-ns/mnt-demo/data.txt && findmnt --mountpoint /tmp/kd-ns/mnt-demo -o TARGET,FSTYPE > /tmp/kd-ns/mnt-evidence.txt'
findmnt --mountpoint /tmp/kd-ns/mnt-demo || echo "host sees no mount here"
cat /tmp/kd-ns/mnt-evidence.txt
