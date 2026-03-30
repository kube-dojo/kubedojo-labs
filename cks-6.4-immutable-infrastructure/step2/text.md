# Enforce Immutability with Security Policies

Use Pod Security Admission and labels to enforce immutable containers.

## Task

1. Create a namespace `immutable-enforced` with PodSecurity restricted enforcement.
2. Try to create a pod WITHOUT readOnlyRootFilesystem in the enforced namespace. Save the error to `/root/enforce-test.txt`.
3. Create a compliant immutable pod in the enforced namespace and verify it starts.
4. Create `/root/immutability-patterns.txt` documenting:
   - What makes a container immutable
   - How to handle applications that need write access
   - Patterns: read-only root + emptyDir, read-only root + configMap

## Hint

The restricted Pod Security Standard requires readOnlyRootFilesystem but does not enforce it for all containers. Additional OPA/Kyverno policies may be needed.
