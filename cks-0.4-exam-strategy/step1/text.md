# Quick Wins — Fix Security Contexts

Practice the fastest CKS tasks: fixing pod security contexts.

## Task (Target: under 3 minutes)

1. Delete the pod `fix-me-1` in `exam-practice` namespace and recreate it with the same image but:
   - `privileged: false`
   - `allowPrivilegeEscalation: false`
2. Delete the pod `fix-me-2` in `exam-practice` namespace and recreate it with:
   - `runAsNonRoot: true`
   - `runAsUser: 1000`
3. Save the security context of the recreated `fix-me-1` pod to `/root/fix1-context.txt` using jsonpath.

## Hint

`kubectl delete pod fix-me-1 -n exam-practice` then recreate with `kubectl run --overrides` or a YAML manifest.
