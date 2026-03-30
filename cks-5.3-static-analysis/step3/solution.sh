#!/bin/bash
cat > /root/security-checklist.txt << 'CHECKLIST'
=== Container Security ===
[ ] runAsNonRoot: true is set
[ ] runAsUser specifies a non-zero UID
[ ] readOnlyRootFilesystem: true is set
[ ] allowPrivilegeEscalation: false is set
[ ] capabilities.drop includes ALL
[ ] No privileged: true
[ ] Image uses specific version tag (not :latest)

=== Pod Security ===
[ ] No hostNetwork: true
[ ] No hostPID: true
[ ] No hostIPC: true
[ ] seccompProfile is RuntimeDefault or Localhost

=== Network Security ===
[ ] NetworkPolicy exists for the namespace
[ ] No hostPort usage
[ ] Services use appropriate type (not NodePort in production)

=== Resource Management ===
[ ] CPU and memory limits are set
[ ] CPU and memory requests are set
CHECKLIST

cat > /root/quick-audit.sh << 'SCRIPT'
#!/bin/bash
FILE=$1
if [ -z "$FILE" ]; then
  echo "Usage: $0 <yaml-file>"
  exit 1
fi
echo "=== Security Audit: $FILE ==="
grep -q "privileged: true" "$FILE" && echo "FAIL: privileged=true found" || echo "PASS: No privileged containers"
grep -q "hostNetwork: true" "$FILE" && echo "FAIL: hostNetwork=true found" || echo "PASS: No hostNetwork"
grep -q "hostPID: true" "$FILE" && echo "FAIL: hostPID=true found" || echo "PASS: No hostPID"
grep -q "runAsNonRoot: true" "$FILE" && echo "PASS: runAsNonRoot=true" || echo "WARN: runAsNonRoot not set"
grep -q "readOnlyRootFilesystem: true" "$FILE" && echo "PASS: readOnlyRootFilesystem" || echo "WARN: readOnlyRootFilesystem not set"
grep -q "allowPrivilegeEscalation: false" "$FILE" && echo "PASS: allowPrivilegeEscalation=false" || echo "WARN: allowPrivilegeEscalation not restricted"
grep -q 'drop:' "$FILE" && echo "PASS: Capabilities dropped" || echo "WARN: No capabilities dropped"
grep -q "hostPath" "$FILE" && echo "FAIL: hostPath volume found" || echo "PASS: No hostPath"
grep -q "limits:" "$FILE" && echo "PASS: Resource limits set" || echo "WARN: No resource limits"
echo ""
SCRIPT
chmod +x /root/quick-audit.sh

{
  /root/quick-audit.sh /root/antipatterns.yaml
  /root/quick-audit.sh /root/antipatterns-fixed.yaml
} > /root/audit-results.txt
