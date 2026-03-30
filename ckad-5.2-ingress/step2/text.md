# Configure Path-Based Routing

## Task

1. Create an Ingress named `path-ingress` in `ingress-lab` with path-based routing:
   - `/frontend` -> `frontend` service port 80
   - `/backend` -> `backend` service port 80
   - Use `pathType: Prefix` for both
   - Set `ingressClassName: nginx`

2. Save the Ingress YAML to `/root/path-ingress.yaml`.
3. Save the number of paths configured to `/root/path-count.txt`.

## Hint

Multiple paths go under the same `http.paths` array. Each path has its own `backend.service`. See the Kubernetes docs: Ingress path matching.
