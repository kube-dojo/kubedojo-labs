# Identify the Compromised Container

Investigate a suspicious pod to identify indicators of compromise.

## Task

1. List all pods in the `investigation` namespace and examine their status. Save to `/root/pod-list.txt`.
2. Examine the processes running in `suspicious-pod`:
   ```bash
   kubectl exec suspicious-pod -n investigation -- ps aux
   ```
   Save to `/root/processes.txt`.
3. Check for suspicious files in `/tmp/`:
   ```bash
   kubectl exec suspicious-pod -n investigation -- ls -la /tmp/
   ```
   Save to `/root/suspicious-files.txt`.
4. Check the container's network connections:
   ```bash
   kubectl exec suspicious-pod -n investigation -- ss -tlnp
   ```
   Save to `/root/network-connections.txt`.

## Hint

Look for: unexpected processes, suspicious files in /tmp, unusual network connections, modified system files.
