# Scan All Running Images in the Cluster

Create a cluster-wide vulnerability report.

## Task

1. Create a script `/root/cluster-scan.sh` that:
   - Lists all unique container images running in the cluster
   - Scans each image with trivy (CRITICAL and HIGH only)
   - Outputs a summary report
2. Run the script and save output to `/root/cluster-scan-results.txt`.
3. Create `/root/scanning-best-practices.txt` with at least 4 scanning best practices.

## Hint

Use `kubectl get pods -A -o jsonpath` to extract unique images. Use `sort -u` to deduplicate.
