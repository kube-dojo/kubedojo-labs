# Add Repos and Search

Helm charts are stored in repositories. The most popular public repo is **Bitnami**.

**Key commands:**
```bash
helm repo add <name> <url>     # Add a repository
helm repo update               # Update repository cache
helm search repo <keyword>     # Search for charts
helm search hub <keyword>      # Search Artifact Hub
```

## Task

1. Add the Bitnami repository: `https://charts.bitnami.com/bitnami`
2. Update the repository cache.
3. Search for the nginx chart and save the full chart name to `/root/nginx-chart.txt`.

The chart name should be in the format `bitnami/nginx`.

## Hint

Run `helm repo add bitnami https://charts.bitnami.com/bitnami`, then `helm repo update`, then `helm search repo bitnami/nginx`.
