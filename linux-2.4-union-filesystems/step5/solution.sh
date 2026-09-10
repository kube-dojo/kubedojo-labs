#!/bin/bash
for f in /tmp/kd-ufs/upper/*; do n=$(basename "$f"); if [ -c "$f" ]; then echo "D $n"; elif [ -e "/tmp/kd-ufs/lower/$n" ]; then echo "C $n"; else echo "A $n"; fi; done | sort > /tmp/kd-ufs/evidence/diff-report.txt
cat /tmp/kd-ufs/evidence/diff-report.txt
sudo umount /tmp/kd-ufs/merged
