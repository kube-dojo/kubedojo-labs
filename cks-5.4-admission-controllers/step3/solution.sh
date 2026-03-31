#!/bin/bash
kubectl create namespace psa-test-ns
kubectl label namespace psa-test-ns pod-security.kubernetes.io/enforce=restricted
{
  echo "Attempting privileged pod in restricted namespace:"
  kubectl run test-priv --image=nginx -n psa-test-ns --overrides='{"spec":{"containers":[{"name":"nginx","image":"nginx","securityContext":{"privileged":true}}]}}' 2>&1
  echo ""
  echo "Attempting compliant pod:"
  kubectl run test-ok --image=busybox -n psa-test-ns --overrides='{"spec":{"securityContext":{"runAsNonRoot":true,"runAsUser":1000,"seccompProfile":{"type":"RuntimeDefault"}},"containers":[{"name":"busybox","image":"busybox","command":["sleep","60"],"securityContext":{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]}}}]}}' 2>&1
} > /root/psa-test.txt
kubectl wait --for=condition=Ready pod/test-ok -n psa-test-ns --timeout=60s 2>/dev/null || true

{
  echo "NodeRestriction limits kubelet to:"
  echo "- Only modify its own Node object labels (with restrictions)"
  echo "- Only modify pods scheduled to this node"
  echo "- Cannot modify other nodes or their pods"
  NODE=$(kubectl get nodes -o name | head -1)
  echo "Current node: $NODE"
} > /root/node-restriction-test.txt

cat > /root/admission-best-practices.txt << 'BEST'
1. Enable PodSecurity admission and set restricted as the default for all namespaces
2. Enable NodeRestriction to limit kubelet permissions to its own node
3. Use ImagePolicyWebhook with defaultAllow: false (fail closed) for image validation
4. Enable AlwaysPullImages in multi-tenant clusters to prevent image cache sharing
5. Use ValidatingAdmissionWebhooks for custom policy enforcement (OPA Gatekeeper, Kyverno)
6. Test admission changes in non-production environments first
7. Monitor admission controller rejection logs for troubleshooting and security events
BEST
