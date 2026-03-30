# Filter and Prioritize Vulnerabilities

Not all CVEs require immediate action. Learn to prioritize based on severity and fixability.

## Task

1. Count CVEs by severity for `nginx:1.19` and save to `/root/cve-counts.txt`:
   - CRITICAL: X
   - HIGH: X
   - MEDIUM: X
   - LOW: X
2. Filter for only fixable vulnerabilities: `trivy image --ignore-unfixed nginx:1.19` and save to `/root/fixable-cves.txt`.
3. Create `/root/cve-priority.txt` documenting your prioritization strategy:
   - Which CVEs to fix immediately
   - Which can wait
   - How to handle unfixable CVEs

## Hint

Use `--ignore-unfixed` to show only vulnerabilities with available fixes. Focus on CRITICAL and HIGH with fixes first.
