#!/bin/bash
kubeadm upgrade plan > /root/upgrade-plan.txt 2>&1
echo "Upgrade plan:"
cat /root/upgrade-plan.txt
