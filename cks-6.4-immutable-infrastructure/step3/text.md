# Verify and Audit Immutability Across the Cluster

Check all running pods for immutability compliance.

## Task

1. Create a script `/root/immutability-audit.sh` that:
   - Lists all pods in all namespaces
   - Checks each container for `readOnlyRootFilesystem: true`
   - Reports compliant and non-compliant pods
2. Run the script and save output to `/root/immutability-report.txt`.
3. Create `/root/immutability-best-practices.txt` with at least 5 best practices for immutable infrastructure.

## Hint

Use `kubectl get pods -A -o json` and parse with Python or jq to check each container's securityContext.
