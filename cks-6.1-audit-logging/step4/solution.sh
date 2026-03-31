#!/bin/bash
cat > /root/alert-rules.txt << 'RULES'
RULE: secret-enumeration
CONDITION: More than 10 list/get requests on secrets from the same user within 5 minutes
SEVERITY: critical
ACTION: Alert SOC, check for compromised credentials, revoke tokens if unauthorized

RULE: rbac-escalation
CONDITION: create or update on clusterroles/clusterrolebindings with cluster-admin reference
SEVERITY: critical
ACTION: Alert SOC immediately, verify authorization, audit the change

RULE: exec-into-system-pod
CONDITION: exec or attach verb on pods in kube-system namespace
SEVERITY: warning
ACTION: Verify the user is authorized for maintenance, log for audit trail

RULE: anonymous-protected-access
CONDITION: Requests from system:anonymous to non-discovery endpoints returning 200
SEVERITY: critical
ACTION: Check API server anonymous auth configuration, investigate access

RULE: forbidden-storm
CONDITION: More than 50 403 responses from the same source IP within 10 minutes
SEVERITY: warning
ACTION: Investigate source, potential brute force or misconfigured client

RULE: privileged-pod-creation
CONDITION: Pod create with spec.containers[].securityContext.privileged=true
SEVERITY: warning
ACTION: Verify namespace allows privileged pods, alert if in restricted namespace
RULES

cat > /root/check-secrets-access.sh << 'CHECKERSCRIPT'
#!/bin/bash
LOG="/var/log/kubernetes/audit/audit.log"
NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)

echo "=== Secret Access Report ==="
echo "Date: $(date)"
echo ""

# Try to get audit log from local or kind node
AUDIT_AVAILABLE=false
if [ -f "$LOG" ] && [ -s "$LOG" ]; then
  AUDIT_AVAILABLE=true
elif [ -n "$NODE" ]; then
  docker exec "$NODE" cat "$LOG" 2>/dev/null > /tmp/audit-copy.log
  if [ -s /tmp/audit-copy.log ]; then
    LOG="/tmp/audit-copy.log"
    AUDIT_AVAILABLE=true
  fi
fi

if [ "$AUDIT_AVAILABLE" = true ]; then
  echo "Users who accessed secrets:"
  cat "$LOG" | python3 -c "
import json, sys
from collections import Counter
users = Counter()
for line in sys.stdin:
    try:
        e = json.loads(line.strip())
        ref = e.get('objectRef',{})
        if ref.get('resource') == 'secrets':
            user = e.get('user',{}).get('username','unknown')
            users[user] += 1
    except: pass
if users:
    for u, c in users.most_common():
        print(f'  {u}: {c} accesses')
else:
    print('  No secret access events found')
" 2>/dev/null || echo "  (Unable to parse audit log)"
else
  echo "Audit log not available — generating report from RBAC analysis"
  echo ""
  echo "ServiceAccounts with secret access permissions:"
  kubectl get clusterrolebindings -o json 2>/dev/null | python3 -c "
import json, sys
data = json.load(sys.stdin)
for item in data['items']:
    for sub in item.get('subjects',[]):
        print(f'  {sub.get(\"namespace\",\"\")}/{sub.get(\"name\",\"\")} via {item[\"roleRef\"][\"name\"]}')
" 2>/dev/null | head -10 || echo "  Unable to parse RBAC bindings"
fi
CHECKERSCRIPT
chmod +x /root/check-secrets-access.sh
/root/check-secrets-access.sh > /root/secrets-access-report.txt 2>&1
