# Configure Readiness Probes

Readiness probes control whether a pod receives traffic from a Service. A pod that fails its readiness probe is removed from service endpoints.

## Task

1. Create a deployment named `ready-app` in `probes-lab` with:
   - Image: `nginx:1.25`
   - Replicas: 3
   - Readiness probe: HTTP GET on `/` port 80, `initialDelaySeconds: 3`, `periodSeconds: 5`
2. Create a service `ready-svc` exposing the deployment on port 80.
3. Save the number of ready endpoints to `/root/ready-endpoints.txt`:
   ```
   kubectl get endpoints ready-svc -n probes-lab -o jsonpath='{.subsets[0].addresses}' | python3 -c "import sys,json; print(len(json.load(sys.stdin)))"
   ```

## Hint

Readiness probes use the same syntax as liveness probes but under `readinessProbe` instead of `livenessProbe`.
