# Contain and Remediate the Incident

After collecting evidence, contain the threat and prevent recurrence.

## Task

1. Immediately isolate the pod by applying a deny-all NetworkPolicy to the `investigation` namespace.
2. Delete the compromised pod: `kubectl delete pod suspicious-pod -n investigation`.
3. Create a hardened replacement deployment at `/root/remediated-deployment.yaml` with:
   - runAsNonRoot: true, runAsUser: 1000
   - readOnlyRootFilesystem: true
   - Drop ALL capabilities
   - RuntimeDefault seccomp
4. Apply the remediated deployment.
5. Create `/root/incident-report.txt` with the complete incident report.

## Hint

Isolate first (NetworkPolicy), collect evidence, then delete. The remediated deployment should fix all security issues found.
