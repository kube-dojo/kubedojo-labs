#!/bin/bash
cat /tmp/kd-ufs/merged/base.txt > /tmp/kd-ufs/evidence/read-through.txt
echo "new file" > /tmp/kd-ufs/merged/new.txt
ls /tmp/kd-ufs/upper > /tmp/kd-ufs/evidence/upper-after-new.txt
cat /tmp/kd-ufs/evidence/read-through.txt /tmp/kd-ufs/evidence/upper-after-new.txt
