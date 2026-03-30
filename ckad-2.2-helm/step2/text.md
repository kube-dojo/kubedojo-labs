# Customize Releases with Values

## Task

1. Create a values file `/root/custom-values.yaml` with:
   ```yaml
   replicaCount: 3
   service:
     type: ClusterIP
   ```
2. Install a new release named `custom-app` in `helm-lab` using the bitnami/nginx chart with your custom values:
   ```
   helm install custom-app bitnami/nginx -n helm-lab -f /root/custom-values.yaml
   ```
3. Verify the deployment has 3 replicas.
4. Save the Helm values for `custom-app` to `/root/custom-app-values.txt`:
   ```
   helm get values custom-app -n helm-lab
   ```

## Hint

Use `helm get values <release> -n <ns>` to see the values used for an installation.
