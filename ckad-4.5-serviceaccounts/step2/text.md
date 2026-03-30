# Assign ServiceAccounts to Pods

## Task

1. Create a pod named `sa-pod` in `sa-lab` with image `busybox:1.36` command `sleep 3600` that uses the `app-sa` ServiceAccount.
2. Verify the ServiceAccount assignment:
   ```
   kubectl get pod sa-pod -n sa-lab -o jsonpath='{.spec.serviceAccountName}'
   ```
3. Check that the token is mounted:
   ```
   kubectl exec sa-pod -n sa-lab -- ls /var/run/secrets/kubernetes.io/serviceaccount/
   ```
4. Save the ServiceAccount name from the pod spec to `/root/pod-sa.txt`.

## Hint

Set `spec.serviceAccountName: app-sa` in the pod spec.
