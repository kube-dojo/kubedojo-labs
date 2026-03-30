# Detect and Respond to Security Events

Trigger security events and practice responding to them.

## Task

1. Create a test pod in `falco-lab` namespace: `kubectl run test-pod --image=nginx -n falco-lab`
2. Trigger security events:
   - Exec into the pod: `kubectl exec -it test-pod -n falco-lab -- bash`
   - Read `/etc/shadow` inside the container
   - Write to `/etc/` directory
3. Check Falco logs for detections: `journalctl -u falco --no-pager | tail -30` (or `/var/log/falco/falco.log`). Save to `/root/falco-detections.txt`.
4. Create `/root/incident-response.txt` documenting:
   - What events were detected
   - How to respond to each event type
   - How to investigate further

## Hint

If Falco is not running, document the expected detections based on the rules you created. The incident response plan is the most important part.
