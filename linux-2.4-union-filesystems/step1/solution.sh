#!/bin/bash
mkdir -p /tmp/kd-ufs/lower /tmp/kd-ufs/upper /tmp/kd-ufs/work /tmp/kd-ufs/merged
echo "base file" > /tmp/kd-ufs/lower/base.txt
echo "original content" > /tmp/kd-ufs/lower/modify.txt
echo "delete me" > /tmp/kd-ufs/lower/delete.txt
sudo mount -t overlay overlay -o lowerdir=/tmp/kd-ufs/lower,upperdir=/tmp/kd-ufs/upper,workdir=/tmp/kd-ufs/work /tmp/kd-ufs/merged
findmnt -no FSTYPE,OPTIONS /tmp/kd-ufs/merged > /tmp/kd-ufs/evidence/mount-info.txt
ls /tmp/kd-ufs/merged > /tmp/kd-ufs/evidence/merged-list.txt
cat /tmp/kd-ufs/evidence/mount-info.txt /tmp/kd-ufs/evidence/merged-list.txt
