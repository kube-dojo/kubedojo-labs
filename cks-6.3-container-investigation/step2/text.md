# Collect Forensic Evidence

Before destroying the compromised container, collect evidence for analysis.

## Task

1. Capture the suspicious files from the container:
   ```bash
   kubectl cp investigation/suspicious-pod:/tmp/malware.sh $HOME/evidence-malware.sh
   kubectl cp investigation/suspicious-pod:/tmp/exfil.txt $HOME/evidence-exfil.txt
   ```
2. Save the full pod specification to `$HOME/evidence-pod-spec.yaml`.
3. Save the container logs to `$HOME/evidence-logs.txt`.
4. Check the container's environment variables for leaked credentials: `kubectl exec suspicious-pod -n investigation -- env`. Save to `$HOME/evidence-env.txt`.
5. Create an evidence summary at `$HOME/evidence-summary.txt` listing all indicators of compromise found.

## Hint

Use `kubectl cp` to extract files before the pod is deleted. Save the pod spec with `kubectl get pod -o yaml`. Evidence must be preserved before containment.
