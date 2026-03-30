# Disable Automatic Token Mounting

Most pods do not need to communicate with the Kubernetes API. Disable automatic token mounting to reduce the attack surface.

## Task

1. Create a ServiceAccount named `no-api-access` in `sa-lab` with `automountServiceAccountToken: false`.
2. Create a pod named `secure-app` in `sa-lab` using the `no-api-access` ServiceAccount and image `nginx`.
3. Verify the pod does not have a mounted token by checking if `/var/run/secrets/kubernetes.io/serviceaccount/token` exists inside the container. Save the result to `/root/token-check.txt`.
4. Create another pod named `needs-api` in `sa-lab` using the default ServiceAccount but with `automountServiceAccountToken: false` set at the pod level.

## Hint

Set `automountServiceAccountToken: false` on the ServiceAccount YAML or on the pod spec directly.
