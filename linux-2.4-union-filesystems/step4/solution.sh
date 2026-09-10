#!/bin/bash
rm /tmp/kd-ufs/merged/delete.txt
ls -la /tmp/kd-ufs/upper > /tmp/kd-ufs/evidence/upper-after-delete.txt
cat /tmp/kd-ufs/evidence/upper-after-delete.txt
ls /tmp/kd-ufs/lower
