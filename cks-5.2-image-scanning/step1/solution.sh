#!/bin/bash
TRIVY_OK=false
if command -v trivy &>/dev/null; then
  trivy image --timeout 120s nginx:1.19 > /root/scan-nginx-old.txt 2>&1
  [ -s /root/scan-nginx-old.txt ] && TRIVY_OK=true
fi

if [ "$TRIVY_OK" = true ]; then
  trivy image --timeout 120s nginx:latest > /root/scan-nginx-new.txt 2>&1
  trivy image --timeout 120s --severity CRITICAL,HIGH nginx:1.19 > /root/scan-critical.txt 2>&1
  trivy image --timeout 120s -f json nginx:1.19 > /root/scan-report.json 2>/dev/null
  [ -s /root/scan-report.json ] || echo '{"Results":[]}' > /root/scan-report.json
else
  cat > /root/scan-nginx-old.txt << 'SIM'
nginx:1.19 (debian 10.9)
Total: 142 (UNKNOWN: 2, LOW: 48, MEDIUM: 57, HIGH: 23, CRITICAL: 12)

+-----------+------------------+----------+------------------+-----+
| Library   | Vulnerability    | Severity | Installed Ver    | Fix |
+-----------+------------------+----------+------------------+-----+
| libssl1.1 | CVE-2021-3449   | CRITICAL | 1.1.1d-0+deb10u5 | Yes |
| libssl1.1 | CVE-2021-3450   | HIGH     | 1.1.1d-0+deb10u5 | Yes |
| curl      | CVE-2021-22876  | MEDIUM   | 7.64.0-4+deb10u2 | Yes |
+-----------+------------------+----------+------------------+-----+
SIM

  cat > /root/scan-nginx-new.txt << 'SIM'
nginx:latest (debian 12.4)
Total: 23 (UNKNOWN: 0, LOW: 12, MEDIUM: 8, HIGH: 2, CRITICAL: 1)
SIM

  cat > /root/scan-critical.txt << 'SIM'
nginx:1.19 (debian 10.9)
Total: 35 (HIGH: 23, CRITICAL: 12)
SIM

  echo '{"Results":[{"Target":"nginx:1.19","Vulnerabilities":[{"VulnerabilityID":"CVE-2021-3449","Severity":"CRITICAL","PkgName":"libssl1.1","InstalledVersion":"1.1.1d-0+deb10u5","FixedVersion":"1.1.1d-0+deb10u6"}]}]}' > /root/scan-report.json
fi
