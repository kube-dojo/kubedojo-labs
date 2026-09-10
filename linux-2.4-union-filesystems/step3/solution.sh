#!/bin/bash
echo "modified content" > /tmp/kd-ufs/merged/modify.txt
cat /tmp/kd-ufs/upper/modify.txt > /tmp/kd-ufs/evidence/upper-modify.txt
cat /tmp/kd-ufs/lower/modify.txt > /tmp/kd-ufs/evidence/lower-modify.txt
cat /tmp/kd-ufs/evidence/upper-modify.txt /tmp/kd-ufs/evidence/lower-modify.txt
