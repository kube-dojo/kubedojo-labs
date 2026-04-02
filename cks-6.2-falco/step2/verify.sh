#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
RULES="/etc/falco/falco_rules.local.yaml"
if [ ! -f "$RULES" ] || [ ! -s "$RULES" ]; then
  echo "FAIL: $RULES missing or empty"
  exit 1
fi
if ! grep -q "rule:" "$RULES"; then
  echo "FAIL: No rules found in custom rules file"
  exit 1
fi
RULE_COUNT=$(grep -c "^- rule:" "$RULES")
if [ "$RULE_COUNT" -lt 4 ]; then
  echo "FAIL: Expected at least 4 rules, found $RULE_COUNT"
  exit 1
fi
if [ ! -f $USER_HOME/custom-rules.yaml ] || [ ! -s $USER_HOME/custom-rules.yaml ]; then
  echo "FAIL: $USER_HOME/custom-rules.yaml missing or empty"
  exit 1
fi
echo "PASS"
exit 0
