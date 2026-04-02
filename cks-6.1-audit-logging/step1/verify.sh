#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
POLICY="/etc/kubernetes/audit/policy.yaml"
if [ ! -f "$POLICY" ]; then
  echo "FAIL: $POLICY not found"
  exit 1
fi
if ! grep -q "audit.k8s.io/v1" "$POLICY"; then
  echo "FAIL: Wrong apiVersion"
  exit 1
fi
if ! grep -q "kind: Policy" "$POLICY"; then
  echo "FAIL: Wrong kind"
  exit 1
fi
if ! grep -q "None" "$POLICY"; then
  echo "FAIL: Should have a None level rule for health endpoints"
  exit 1
fi
if ! grep -q "RequestResponse" "$POLICY"; then
  echo "FAIL: Should have RequestResponse level for RBAC"
  exit 1
fi
if [ ! -f $USER_HOME/audit-rule-count.txt ] || [ ! -s $USER_HOME/audit-rule-count.txt ]; then
  echo "FAIL: $USER_HOME/audit-rule-count.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
