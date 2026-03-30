# Configure Host-Based Routing

## Task

1. Create an Ingress named `host-ingress` in `ingress-lab` with host-based routing:
   - `frontend.example.com` -> `frontend` service port 80
   - `backend.example.com` -> `backend` service port 80
   - Set `ingressClassName: nginx`

2. Save the hosts to `/root/ingress-hosts.txt`:
   ```
   kubectl get ingress host-ingress -n ingress-lab -o jsonpath='{.spec.rules[*].host}'
   ```

## Hint

Host-based routing uses the `host` field under each rule. Each host can have its own set of paths. See the Kubernetes docs: Name-based virtual hosting.
