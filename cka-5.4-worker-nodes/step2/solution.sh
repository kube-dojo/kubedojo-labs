#!/bin/bash
echo "=== Kubelet Status ===" > /root/kubelet-config.txt
systemctl is-active kubelet >> /root/kubelet-config.txt
echo "" >> /root/kubelet-config.txt
echo "=== Key Config ===" >> /root/kubelet-config.txt
grep -E "clusterDNS|clusterDomain|staticPodPath|cgroupDriver" /var/lib/kubelet/config.yaml >> /root/kubelet-config.txt
cat /root/kubelet-config.txt
