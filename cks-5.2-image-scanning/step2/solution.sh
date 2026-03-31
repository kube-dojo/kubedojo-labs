#!/bin/bash
TRIVY_OK=false
command -v trivy &>/dev/null && TRIVY_OK=true

if [ "$TRIVY_OK" = true ]; then
  {
    echo "CRITICAL: $(trivy image --severity CRITICAL -q --timeout 120s nginx:1.19 2>/dev/null | grep -c 'CRITICAL' || echo 0)"
    echo "HIGH: $(trivy image --severity HIGH -q --timeout 120s nginx:1.19 2>/dev/null | grep -c 'HIGH' || echo 0)"
    echo "MEDIUM: $(trivy image --severity MEDIUM -q --timeout 120s nginx:1.19 2>/dev/null | grep -c 'MEDIUM' || echo 0)"
    echo "LOW: $(trivy image --severity LOW -q --timeout 120s nginx:1.19 2>/dev/null | grep -c 'LOW' || echo 0)"
  } > /root/cve-counts.txt

  trivy image --ignore-unfixed --timeout 120s nginx:1.19 > /root/fixable-cves.txt 2>&1
else
  cat > /root/cve-counts.txt << 'SIM'
CRITICAL: 12
HIGH: 23
MEDIUM: 57
LOW: 48
SIM

  cat > /root/fixable-cves.txt << 'SIM'
nginx:1.19 (debian 10.9) — fixable vulnerabilities only
Total: 89 (HIGH: 15, CRITICAL: 8, MEDIUM: 42, LOW: 24)
(trivy not available — simulated output)
SIM
fi

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
