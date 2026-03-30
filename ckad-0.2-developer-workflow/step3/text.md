# Use kubectl diff and apply for Declarative Updates

The setup script created a deployment called `webapp` with image `nginx:1.24` and 2 replicas in the `dev-workflow` namespace. You need to update it declaratively.

## Task

1. Export the current `webapp` deployment to `/root/webapp.yaml`:
   ```
   kubectl get deployment webapp -n dev-workflow -o yaml > /root/webapp.yaml
   ```
2. Edit `/root/webapp.yaml` to change the image from `nginx:1.24` to `nginx:1.25` and replicas from 2 to 4.
3. Run `kubectl diff -f /root/webapp.yaml -n dev-workflow` to preview the changes (no need to save output).
4. Apply the updated manifest with `kubectl apply -f /root/webapp.yaml -n dev-workflow`.
5. Wait for the rollout to complete.

## Hint

Use `sed -i 's/nginx:1.24/nginx:1.25/' /root/webapp.yaml` and `sed -i 's/replicas: 2/replicas: 4/' /root/webapp.yaml` for quick edits.
