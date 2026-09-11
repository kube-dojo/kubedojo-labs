# Restrict API Server Network Access

Understand how the API server is exposed and document the attack surface.

## Task

1. Find the API server's listen address and port from the manifest. Save to `"$HOME"/apiserver-endpoint.txt`.
2. Check if the API server is accessible from within a pod. Create a test pod and try to reach the API server. Save the result to `"$HOME"/pod-api-access.txt`.
3. List all ports the API server listens on (secure and insecure) and save to `"$HOME"/apiserver-ports.txt`.
4. Create `"$HOME"/api-network-controls.txt` documenting 4 ways to restrict API server network access.

## Hint

The API server endpoint is in the kubeconfig at `~/.kube/config`. The Kubernetes service in the default namespace also points to the API server.
