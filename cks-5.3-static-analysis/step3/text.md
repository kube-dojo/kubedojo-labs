# Create a Security Review Checklist

Build a reusable checklist for reviewing Kubernetes manifests before deployment.

## Task

1. Create `/root/security-checklist.txt` with a comprehensive manifest review checklist covering:
   - Container security (at least 5 checks)
   - Pod security (at least 3 checks)
   - Network security (at least 3 checks)
   - Resource management (at least 2 checks)
2. Create a script `/root/quick-audit.sh` that checks a given YAML file for the most critical security issues and outputs pass/fail for each. Test it on your manifests.
3. Run the script on both `/root/antipatterns.yaml` and `/root/antipatterns-fixed.yaml`. Save output to `/root/audit-results.txt`.

## Hint

Use `grep` to check for presence or absence of security fields in YAML files. Check for: privileged, hostNetwork, runAsNonRoot, readOnlyRootFilesystem, capabilities, resources.
