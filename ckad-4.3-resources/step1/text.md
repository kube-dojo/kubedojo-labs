# Set Resource Requests and Limits

## Task

1. Create a pod named `resource-pod` in `resources-lab` with image `nginx:1.25` and:
   - CPU request: `100m`, CPU limit: `200m`
   - Memory request: `64Mi`, Memory limit: `128Mi`
2. Verify the resources are set:
   ```
   kubectl get pod resource-pod -n resources-lab -o jsonpath='{.spec.containers[0].resources}'
   ```
3. Save the CPU limit to `/root/cpu-limit.txt`.

## Hint

Add `resources.requests` and `resources.limits` under the container spec. CPU is in millicores (m), memory in Mi/Gi.
