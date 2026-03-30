#!/bin/bash
mkdir -p /etc/kubernetes/audit
cat > /etc/kubernetes/audit/exam-policy.yaml << 'POLICY'
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  - level: RequestResponse
    resources:
      - group: ""
        resources: ["secrets"]
    verbs: ["create", "delete"]
  - level: Metadata
    namespaces: ["kube-system"]
  - level: None
    resources:
      - group: ""
        resources: ["*"]
POLICY

cat > /root/exam-notes.txt << 'NOTES'
Quick: Fix pod security context to runAsNonRoot
Quick: Create ServiceAccount with limited permissions
Quick: Delete privileged pod and recreate securely
Medium: Create NetworkPolicy to restrict pod traffic
Medium: Configure RBAC Role and RoleBinding
Medium: Enable Pod Security Admission on namespace
Complex: Configure audit logging with custom policy
Complex: Set up admission webhook for image validation
Complex: Configure encryption at rest for secrets
NOTES
