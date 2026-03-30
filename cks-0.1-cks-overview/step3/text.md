# Practice Triage — Identify Security Misconfigurations

In the exam, you must quickly spot security issues. Practice identifying insecure workloads.

## Task

1. List all pods in the `security-test` namespace and examine their security contexts.
2. Identify which pod is running as privileged and save its name to `/root/insecure-pod.txt`.
3. Identify which pod has `readOnlyRootFilesystem: true` and save its name to `/root/secure-pod.txt`.
4. Create a file `/root/security-fixes.txt` listing three security improvements for the insecure pod (one per line).

## Hint

Use `kubectl get pod -n security-test -o jsonpath` to extract security context fields. Check `spec.containers[].securityContext`.
