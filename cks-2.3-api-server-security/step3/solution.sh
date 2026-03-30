#!/bin/bash
grep 'enable-admission-plugins' /etc/kubernetes/manifests/kube-apiserver.yaml | awk -F= '{print $2}' > /root/admission-plugins.txt
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
