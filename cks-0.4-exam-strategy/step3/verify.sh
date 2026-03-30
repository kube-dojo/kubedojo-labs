#!/bin/bash
POLICY="/etc/kubernetes/audit/exam-policy.yaml"
if [ ! -f "$POLICY" ]; then
  echo "FAIL: $POLICY not found"
  exit 1
fi
if ! grep -q "RequestResponse" "$POLICY"; then
  echo "FAIL: Missing RequestResponse level in audit policy"
  exit 1
fi
if ! grep -q "kube-system" "$POLICY"; then
  echo "FAIL: Missing kube-system namespace rule"
  exit 1
fi
if [ ! -f /root/exam-notes.txt ]; then
  echo "FAIL: /root/exam-notes.txt not found"
  exit 1
fi
LINES=$(wc -l < /root/exam-notes.txt | tr -d ' ')
if [ "$LINES" -lt 9 ]; then
  echo "FAIL: Expected at least 9 lines in exam-notes.txt, got $LINES"
  exit 1
fi
echo "PASS"
exit 0
