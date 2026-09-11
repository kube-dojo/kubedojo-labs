# Test and Validate Admission Controls

Test how existing admission controllers affect pod creation.

## Task

1. Test PodSecurity admission by creating a restricted namespace and attempting to deploy an insecure pod. Save the result to `"$HOME"/psa-test.txt`.
2. Test NodeRestriction by examining what the kubelet can and cannot modify. Save to `"$HOME"/node-restriction-test.txt`.
3. Create `"$HOME"/admission-best-practices.txt` with at least 5 admission controller best practices.

## Hint

Use `kubectl label namespace` to set PodSecurity levels. Use `kubectl auth can-i` with `--as` to test permissions.
