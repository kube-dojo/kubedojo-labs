#!/bin/bash
mkdir -p /etc/kubernetes/audit
cat > /etc/kubernetes/audit/audit-policy.yaml << 'POLICY'
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  - level: Metadata
    resources:
      - group: ""
        resources: ["secrets"]
  - level: Request
    resources:
      - group: ""
        resources: ["pods"]
  - level: None
    resources:
      - group: ""
        resources: ["*"]
POLICY
echo "3" > /root/audit-rule-count.txt
