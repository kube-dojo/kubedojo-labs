#!/bin/bash
cat > /etc/kubernetes/audit/policy.yaml << 'POLICY'
apiVersion: audit.k8s.io/v1
kind: Policy
omitStages:
  - "RequestReceived"
rules:
  # Skip health endpoints
  - level: None
    nonResourceURLs:
      - /healthz*
      - /readyz*
      - /livez*

  # Log secret operations at Metadata only (avoid logging data)
  - level: Metadata
    resources:
      - group: ""
        resources: ["secrets"]

  # Log token-related operations
  - level: Metadata
    resources:
      - group: "authentication.k8s.io"
        resources: ["tokenreviews"]

  # Log RBAC changes at RequestResponse for full audit trail
  - level: RequestResponse
    resources:
      - group: "rbac.authorization.k8s.io"
        resources: ["roles", "rolebindings", "clusterroles", "clusterrolebindings"]

  # Log pod changes at Request level
  - level: Request
    resources:
      - group: ""
        resources: ["pods"]
    verbs: ["create", "delete", "patch", "update"]

  # Log everything else at Metadata
  - level: Metadata
    resources:
      - group: ""
        resources: ["*"]
POLICY

grep -c "level:" /etc/kubernetes/audit/policy.yaml > /root/audit-rule-count.txt
