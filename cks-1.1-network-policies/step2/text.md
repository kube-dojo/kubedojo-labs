# Allow Specific Pod-to-Pod Communication

After denying all traffic, selectively allow required communication paths.

## Task

1. Create a NetworkPolicy named `allow-frontend-to-api` in the `backend` namespace that:
   - Applies to pods with label `app=api`
   - Allows ingress from pods with label `app=web` in the `frontend` namespace
   - Allows only TCP port 80
2. Verify that `frontend/web` can now reach `backend/api` on port 80 and save the HTTP response code to `/root/netpol-test-2.txt`.

## Hint

Use `namespaceSelector` with a label matching the frontend namespace, combined with `podSelector` for the web pod. You may need to label the frontend namespace first.
