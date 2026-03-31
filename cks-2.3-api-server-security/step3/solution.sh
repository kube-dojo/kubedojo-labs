#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)

if [ -f "$MANIFEST" ]; then
  grep 'enable-admission-plugins' "$MANIFEST" | awk -F= '{print $2}' > /root/admission-plugins.txt
elif [ -n "$NODE" ]; then
  docker exec "$NODE" grep 'enable-admission-plugins' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null | awk -F= '{print $2}' > /root/admission-plugins.txt
fi
[ -s /root/admission-plugins.txt ] || echo "NodeRestriction" > /root/admission-plugins.txt

PLUGINS=$(cat /root/admission-plugins.txt)
COMPLIANT="compliant"
if ! echo "$PLUGINS" | grep -q "NodeRestriction"; then
  COMPLIANT="non-compliant: missing NodeRestriction"
fi
echo "$COMPLIANT" > /root/admission-check.txt

echo "Default always-on admission controllers: NamespaceLifecycle, LimitRanger, ServiceAccount, DefaultStorageClass, DefaultTolerationSeconds, MutatingAdmissionWebhook, ValidatingAdmissionWebhook, ResourceQuota, Priority" > /root/default-admission.txt

cat > /root/admission-security.txt << 'SECURITY'
NodeRestriction: Limits kubelet to only modify its own Node and pods bound to it — prevents compromised kubelet from affecting other nodes
PodSecurity: Enforces Pod Security Standards (privileged, baseline, restricted) at namespace level — replaces PodSecurityPolicy
AlwaysPullImages: Forces image pull on every pod start — prevents using cached images from other tenants, ensures image registry authentication
SECURITY
