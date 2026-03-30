## Troubleshoot kubelet

The kubelet is the primary node agent. When it fails, the node stops managing pods.

### Task

1. Check the kubelet service status
2. View recent kubelet logs
3. Examine the kubelet configuration
4. Save kubelet config details to `/root/kubelet-config.txt`

```bash
# Check kubelet status
systemctl status kubelet

# View recent logs (last 50 lines)
journalctl -u kubelet --no-pager -n 50

# Find kubelet config
ps aux | grep kubelet | grep config

# Check kubelet config file
cat /var/lib/kubelet/config.yaml | head -30

# Save config details
echo "=== Kubelet Status ===" > /root/kubelet-config.txt
systemctl is-active kubelet >> /root/kubelet-config.txt
echo "" >> /root/kubelet-config.txt
echo "=== Key Config ===" >> /root/kubelet-config.txt
grep -E "clusterDNS|clusterDomain|staticPodPath|cgroupDriver" /var/lib/kubelet/config.yaml >> /root/kubelet-config.txt
```

<details>
<summary>Hint: Common kubelet issues</summary>

```bash
# If kubelet is not running:
systemctl start kubelet
systemctl enable kubelet

# Check for config errors:
journalctl -u kubelet | grep -i error | tail -10

# Common problems:
# - Wrong container runtime socket
# - Certificate issues
# - Wrong --config path
# - cgroup driver mismatch with container runtime
```
</details>
