# Install and Manage Helm Releases

## Task

1. Add the Bitnami Helm repository:
   ```
   helm repo add bitnami https://charts.bitnami.com/bitnami
   helm repo update
   ```
2. Search for the nginx chart: `helm search repo bitnami/nginx`.
3. Install the nginx chart as release `web-app` in the `helm-lab` namespace:
   ```
   helm install web-app bitnami/nginx -n helm-lab
   ```
4. List Helm releases in `helm-lab` and save the output to `/root/helm-releases.txt`.

## Hint

Use `helm list -n helm-lab` to list releases in a namespace.
