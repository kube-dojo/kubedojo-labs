#!/bin/bash
echo "=== Kubelet Status ===" > "$HOME"/kubelet-config.txt
systemctl is-active kubelet >> "$HOME"/kubelet-config.txt
echo "" >> "$HOME"/kubelet-config.txt
echo "=== Key Config ===" >> "$HOME"/kubelet-config.txt
sudo grep -E "clusterDNS|clusterDomain|staticPodPath|cgroupDriver" /var/lib/kubelet/config.yaml >> "$HOME"/kubelet-config.txt
cat "$HOME"/kubelet-config.txt
