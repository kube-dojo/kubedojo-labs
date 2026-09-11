#!/bin/bash
sudo kubeadm upgrade plan > "$HOME"/upgrade-plan.txt 2>&1
echo "Upgrade plan:"
cat "$HOME"/upgrade-plan.txt
