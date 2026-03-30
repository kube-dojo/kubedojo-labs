# Scan Images for CVEs with Trivy

Use trivy to scan container images and identify vulnerabilities.

## Task

1. Scan `nginx:1.19` and save the full report to `/root/scan-nginx-old.txt`.
2. Scan `nginx:latest` and save to `/root/scan-nginx-new.txt`.
3. Scan only for CRITICAL and HIGH severity: `trivy image --severity CRITICAL,HIGH nginx:1.19`. Save to `/root/scan-critical.txt`.
4. Generate a JSON report: `trivy image -f json nginx:1.19 > /root/scan-report.json`.

## Hint

trivy caches the vulnerability database locally. First scan may take longer. Use `--severity` to filter and `-f json` for machine-readable output.
