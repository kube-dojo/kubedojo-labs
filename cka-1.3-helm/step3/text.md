# Install a Chart

Installing a chart creates a **release** — a running instance of the chart in your cluster.

**Key commands:**
```bash
helm install <release-name> <chart>          # Install
helm install web bitnami/nginx               # Example
helm list                                     # List releases
helm status <release-name>                   # Show release status
```

## Task

Install the `bitnami/nginx` chart as a release named `web`.

Wait for the deployment to become available (this may take a minute or two).

## Hint

Run `helm install web bitnami/nginx --wait --timeout 5m`. The `--wait` flag waits for pods to be ready. Then verify with `helm list`.
