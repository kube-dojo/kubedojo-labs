# Scan Container Images with Trivy

Trivy scans container images for known vulnerabilities. Practice scanning images used in your cluster.

## Task

1. Scan the `nginx:1.19` image with trivy and save results to `/root/trivy-nginx-old.txt`.
2. Scan the `nginx:latest` image and save results to `/root/trivy-nginx-latest.txt`.
3. Count the number of CRITICAL vulnerabilities in `nginx:1.19` and save to `/root/critical-count.txt`.
4. Generate a JSON report for `nginx:1.19` and save to `/root/trivy-report.json`.

## Hint

Use `trivy image --severity CRITICAL nginx:1.19` to filter by severity. Use `-f json` for JSON output.
