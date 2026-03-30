# Collect Forensic Evidence

Before destroying the compromised container, collect evidence for analysis.

## Task

1. Capture the suspicious files from the container:
   ```bash
   kubectl cp investigation/suspicious-pod:/tmp/malware.sh /root/evidence-malware.sh
   kubectl cp investigation/suspicious-pod:/tmp/exfil.txt /root/evidence-exfil.txt
   ```
2. Save the full pod specification to `/root/evidence-pod-spec.yaml`.
3. Save the container logs to `/root/evidence-logs.txt`.
4. Check the container's environment variables for leaked credentials: `kubectl exec suspicious-pod -n investigation -- env`. Save to `/root/evidence-env.txt`.
5. Create an evidence summary at `/root/evidence-summary.txt` listing all indicators of compromise found.

## Hint

Use `kubectl cp` to extract files before the pod is deleted. Save the pod spec with `kubectl get pod -o yaml`. Evidence must be preserved before containment.
