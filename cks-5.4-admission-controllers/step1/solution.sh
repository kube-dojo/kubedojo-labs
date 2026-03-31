#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
if [ -f "$MANIFEST" ]; then
  grep 'enable-admission-plugins' "$MANIFEST" > /root/enabled-plugins.txt || echo "Using defaults" > /root/enabled-plugins.txt
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep 'enable-admission-plugins' /etc/kubernetes/manifests/kube-apiserver.yaml > /root/enabled-plugins.txt 2>/dev/null || echo "Using defaults" > /root/enabled-plugins.txt
  else
    echo "Using defaults: NodeRestriction" > /root/enabled-plugins.txt
  fi
fi

cat > /root/security-plugins.txt << 'PLUGINS'
AlwaysPullImages: Forces re-pull on every pod start. Prevents using cached images from other tenants. Important in multi-tenant clusters.

DenyServiceExternalIPs: Prevents creating Services with externalIPs. Mitigates CVE-2020-8554 (man-in-the-middle via externalIP).

NodeRestriction: Limits kubelet permissions to only its own Node object and pods scheduled to it. Prevents compromised kubelets from affecting other nodes.

PodSecurity: Enforces Pod Security Standards (privileged, baseline, restricted) at namespace level. Replacement for PodSecurityPolicy.

ServiceAccount: Automates ServiceAccount token mounting and adds imagePullSecrets. Can be configured with automountServiceAccountToken.
PLUGINS

if [ -f "$MANIFEST" ]; then
  if grep -q "AlwaysPullImages" "$MANIFEST"; then
    echo "enabled" > /root/always-pull-status.txt
  else
    echo "disabled" > /root/always-pull-status.txt
  fi
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -q "AlwaysPullImages" /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null && echo "enabled" > /root/always-pull-status.txt || echo "disabled" > /root/always-pull-status.txt
  else
    echo "disabled" > /root/always-pull-status.txt
  fi
fi

cat > /root/admission-flow.txt << 'FLOW'
API Request Flow:
1. Authentication — Who is making the request? (certs, tokens, OIDC)
2. Authorization — Is this user allowed? (RBAC, Node, Webhook)
3. Mutating Admission — Modify the request (defaults, injections)
4. Object Schema Validation — Is the object valid?
5. Validating Admission — Accept or reject (policy checks)
6. Persistence — Write to etcd
FLOW
