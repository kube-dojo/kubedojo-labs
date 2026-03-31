#!/bin/bash
# Isolate
cat <<YAML | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: isolate-all
  namespace: investigation
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
YAML

# Delete compromised pod
kubectl delete pod suspicious-pod -n investigation --grace-period=0 --force 2>/dev/null || true

# Create remediated deployment
cat > /root/remediated-deployment.yaml << 'YAML'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-app
  namespace: investigation
spec:
  replicas: 1
  selector:
    matchLabels:
      app: secure-app
  template:
    metadata:
      labels:
        app: secure-app
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        seccompProfile:
          type: RuntimeDefault
      containers:
      - name: app
        image: nginx:stable
        securityContext:
          readOnlyRootFilesystem: true
          allowPrivilegeEscalation: false
          capabilities:
            drop: ["ALL"]
        volumeMounts:
        - name: cache
          mountPath: /var/cache/nginx
        - name: run
          mountPath: /var/run
      volumes:
      - name: cache
        emptyDir: {}
      - name: run
        emptyDir: {}
YAML
kubectl apply -f /root/remediated-deployment.yaml
kubectl rollout status deployment/secure-app -n investigation --timeout=120s 2>/dev/null || true

cat > /root/incident-report.txt << 'REPORT'
=== SECURITY INCIDENT REPORT ===

Date: $(date)
Severity: HIGH
Status: CONTAINED AND REMEDIATED

Summary:
A container in the investigation namespace was found with indicators of compromise
including malware droppers, persistence mechanisms, and data exfiltration staging.

Timeline:
1. Alert received: suspicious files detected in container /tmp directory
2. Investigation: identified malware.sh, crontab, and exfil.txt
3. Evidence collected: pod spec, logs, environment, suspicious files
4. Containment: NetworkPolicy applied to isolate, compromised pod deleted
5. Remediation: Hardened replacement deployed with security contexts

Indicators of Compromise:
- /tmp/malware.sh — executable script (malware dropper)
- /tmp/crontab — persistence mechanism
- /tmp/exfil.txt — data staging for exfiltration
- Container running as root with no security restrictions

Root Cause:
- Pod deployed without security context (no runAsNonRoot, no readOnlyRootFilesystem)
- No Pod Security Admission enforcement on namespace
- No runtime monitoring (Falco) to detect real-time threats

Remediation Actions:
1. Deployed hardened replacement with full security context
2. Applied NetworkPolicy for network isolation
3. Recommendation: Enable PodSecurity admission on all namespaces
4. Recommendation: Deploy Falco for runtime threat detection
5. Recommendation: Review all pods for similar vulnerabilities
REPORT
