#!/bin/bash
{
  echo "CRITICAL: $(trivy image --severity CRITICAL -q nginx:1.19 2>/dev/null | grep -c 'CRITICAL' || echo 0)"
  echo "HIGH: $(trivy image --severity HIGH -q nginx:1.19 2>/dev/null | grep -c 'HIGH' || echo 0)"
  echo "MEDIUM: $(trivy image --severity MEDIUM -q nginx:1.19 2>/dev/null | grep -c 'MEDIUM' || echo 0)"
  echo "LOW: $(trivy image --severity LOW -q nginx:1.19 2>/dev/null | grep -c 'LOW' || echo 0)"
} > /root/cve-counts.txt

trivy image --ignore-unfixed nginx:1.19 > /root/fixable-cves.txt 2>&1

cat > /root/cve-priority.txt << 'PRIORITY'
CVE Prioritization Strategy:

Fix immediately:
- CRITICAL with available fix — active exploitation risk
- HIGH with available fix in internet-facing services

Schedule for next sprint:
- MEDIUM with available fix
- HIGH without fix (mitigate with network policies, WAF)

Accept or monitor:
- LOW severity
- Unfixed CVEs in non-critical internal services
- CVEs in packages not used at runtime

Handling unfixable CVEs:
- Apply compensating controls (network policies, seccomp, AppArmor)
- Consider switching to a different base image
- Document accepted risk with a security exception
PRIORITY
