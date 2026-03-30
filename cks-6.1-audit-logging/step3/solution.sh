#!/bin/bash
cat > /root/audit-analyzer.sh << 'SCRIPT'
#!/bin/bash
LOG="/var/log/kubernetes/audit/audit.log"
if [ ! -f "$LOG" ] || [ ! -s "$LOG" ]; then
  echo "No audit log found at $LOG"
  echo "Creating sample analysis based on cluster activity..."
  kubectl get pods -A > /dev/null 2>&1
  kubectl get secrets -A > /dev/null 2>&1
  sleep 2
fi

echo "=== Audit Log Analysis ==="
if [ -f "$LOG" ] && [ -s "$LOG" ]; then
  TOTAL=$(wc -l < "$LOG")
  echo "Total events: $TOTAL"
  echo ""
  echo "Events by verb:"
  cat "$LOG" | python3 -c "
import json, sys
from collections import Counter
verbs = Counter()
secrets = 0
non_system = 0
for line in sys.stdin:
    try:
        e = json.loads(line.strip())
        verbs[e.get('verb','')] += 1
        ref = e.get('objectRef',{})
        if ref.get('resource') == 'secrets':
            secrets += 1
        user = e.get('user',{}).get('username','')
        if not user.startswith('system:'):
            non_system += 1
    except: pass
for v, c in verbs.most_common():
    print(f'  {v}: {c}')
print(f'\nEvents involving secrets: {secrets}')
print(f'Events from non-system users: {non_system}')
" 2>/dev/null || echo "  (Python parse failed, log may not be JSON)"
else
  echo "Audit log not available yet"
  echo "Total events: 0"
fi
SCRIPT
chmod +x /root/audit-analyzer.sh
/root/audit-analyzer.sh > /root/audit-analysis.txt 2>&1

cat > /root/suspicious-patterns.txt << 'PATTERNS'
Suspicious Audit Patterns:

1. Secret enumeration — many list/get requests on secrets from a single user
2. RBAC escalation — create/update on roles or clusterroles granting admin access
3. Exec into pods — frequent exec requests, especially to system pods
4. Anonymous access — requests with user system:anonymous accessing protected resources
5. 403 storms — many forbidden responses from the same source (brute force)
6. Service account token creation — unexpected tokenrequest operations
7. Pod creation with privileged security context
8. Namespace creation/deletion by unauthorized users
9. Node modification — changes to node labels or taints from non-admin users
10. ConfigMap/Secret modification in kube-system namespace
PATTERNS
