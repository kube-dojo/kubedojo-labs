#!/bin/bash
kubectl cp investigation/suspicious-pod:/tmp/malware.sh /root/evidence-malware.sh 2>/dev/null || echo "Could not extract" > /root/evidence-malware.sh
kubectl cp investigation/suspicious-pod:/tmp/exfil.txt /root/evidence-exfil.txt 2>/dev/null || echo "Could not extract" > /root/evidence-exfil.txt
kubectl get pod suspicious-pod -n investigation -o yaml > /root/evidence-pod-spec.yaml
kubectl logs suspicious-pod -n investigation > /root/evidence-logs.txt 2>&1
kubectl exec suspicious-pod -n investigation -- env > /root/evidence-env.txt 2>&1 || echo "Cannot read env" > /root/evidence-env.txt

cat > /root/evidence-summary.txt << 'SUMMARY'
=== Indicators of Compromise ===

1. Suspicious executable: /tmp/malware.sh — potential malware dropper
2. Crontab file: /tmp/crontab — persistence mechanism attempt
3. Data file: /tmp/exfil.txt — possible data exfiltration staging
4. Container running as root — elevated privileges
5. No security context restrictions — privileged container

Timeline:
- Container started with inline script that created suspicious files
- Malware dropper placed in /tmp
- Crontab created for persistence
- Data staged for exfiltration

Severity: HIGH
SUMMARY
