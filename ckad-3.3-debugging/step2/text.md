# Debug Pending Pods and Resource Issues

The pod `pending-pod` in `debug-lab` is stuck in Pending state. Diagnose and fix it.

## Task

1. Check why `pending-pod` is Pending: `kubectl describe pod pending-pod -n debug-lab`.
2. The pod requests 100 CPUs and 1000Gi memory — far more than available.
3. Delete the pod and recreate it with reasonable resources:
   - CPU request: `100m`
   - Memory request: `128Mi`
4. Verify it reaches Running state.

## Hint

Look at the Events section of `kubectl describe`. The scheduler cannot find a node with enough resources. See Kubernetes docs: Debug Pods and ReplicaSets.
