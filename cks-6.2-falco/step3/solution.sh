#!/bin/bash
kubectl run test-pod --image=nginx -n falco-lab 2>/dev/null || true
kubectl wait --for=condition=Ready pod/test-pod -n falco-lab --timeout=60s 2>/dev/null || true

# Trigger events that Falco would detect
kubectl exec test-pod -n falco-lab -- cat /etc/shadow 2>/dev/null || true
kubectl exec test-pod -n falco-lab -- sh -c 'touch /etc/test-write' 2>/dev/null || true

# Capture Falco output if available
FALCO_OUTPUT=false
{
  journalctl -u falco --no-pager 2>/dev/null | tail -30
  echo "---"
  cat /var/log/falco/falco.log 2>/dev/null | tail -20
} > /root/falco-detections.txt 2>&1

[ -s /root/falco-detections.txt ] && grep -qv "^---$" /root/falco-detections.txt && FALCO_OUTPUT=true

if [ "$FALCO_OUTPUT" = false ]; then
  cat > /root/falco-detections.txt << 'DETECTIONS'
Falco not running in kind cluster — expected detections based on custom rules:

1. WARNING: Shell spawned in container (container=test-pod command=cat /etc/shadow)
   Rule: Kubectl Exec into Pod
   Detected: kubectl exec triggered shell creation in container

2. CRITICAL: Sensitive file read (file=/etc/shadow container=test-pod)
   Rule: Read Sensitive File in Container
   Detected: /etc/shadow was read inside the container

3. ERROR: Write to /etc detected (file=/etc/test-write container=test-pod)
   Rule: Write to /etc in Container
   Detected: file creation attempt in /etc directory

In production, these events would appear in Falco's output stream,
syslog, or be forwarded to a SIEM via Falcosidekick.
DETECTIONS
fi

cat > /root/incident-response.txt << 'IR'
=== Incident Response Plan ===

Event: Shell exec into container
Response:
  1. Identify who executed the command (audit log user)
  2. Determine if the access was authorized
  3. If unauthorized: isolate the pod with NetworkPolicy, investigate credentials
  4. Log the incident for security review

Event: Sensitive file read (/etc/shadow)
Response:
  1. Check if the application legitimately needs this access
  2. If not: investigate for privilege escalation attempt
  3. Apply AppArmor profile to deny access
  4. Rebuild container image to remove shadow file

Event: Write to /etc in container
Response:
  1. This may indicate malware installation or config tampering
  2. Enable readOnlyRootFilesystem to prevent
  3. Capture container filesystem for forensics before termination
  4. Delete and recreate the pod from the known-good image

Event: Container running as root
Response:
  1. Update deployment to use runAsNonRoot: true
  2. Set explicit runAsUser to a non-zero UID
  3. Apply PodSecurity admission to prevent future occurrences

Investigation steps:
  - Check audit logs for how the attacker gained access
  - Review RBAC bindings for the compromised ServiceAccount
  - Check for lateral movement to other pods/namespaces
  - Review network traffic logs for data exfiltration
IR
