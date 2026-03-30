# Debug CrashLoopBackOff Pods

The pod `crasher` in `debug-lab` is in CrashLoopBackOff. Find and fix the issue.

## Task

1. Check the status of `crasher`: `kubectl get pod crasher -n debug-lab`.
2. View its logs: `kubectl logs crasher -n debug-lab`.
3. Describe the pod to see events: `kubectl describe pod crasher -n debug-lab`.
4. The pod exits with code 1. Fix it by deleting and recreating it with a command that succeeds:
   ```
   kubectl run crasher --image=busybox:1.36 -n debug-lab -- sh -c "echo running; sleep 3600"
   ```
5. Save the exit code reason to `/root/crash-reason.txt` (write "exit 1" as the reason).

## Hint

CrashLoopBackOff means the container keeps restarting. Check logs to see why — in this case, the command exits with code 1. See Kubernetes docs: Debug Running Pods.
