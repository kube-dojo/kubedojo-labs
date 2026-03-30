#!/bin/bash
mkdir -p /etc/kubernetes/admission
cat > /etc/kubernetes/admission/image-policy.yaml << 'YAML'
apiVersion: apiserver.config.k8s.io/v1
kind: AdmissionConfiguration
plugins:
- name: ImagePolicyWebhook
  configuration:
    imagePolicy:
      kubeConfigFile: /etc/kubernetes/admission/image-policy-kubeconfig.yaml
      allowTTL: 50
      denyTTL: 50
      retryBackoff: 500
      defaultAllow: false
YAML

cat > /etc/kubernetes/admission/image-policy-kubeconfig.yaml << 'YAML'
apiVersion: v1
kind: Config
clusters:
- name: image-policy
  cluster:
    server: https://image-policy.example.com:8443/validate
    certificate-authority: /etc/kubernetes/pki/ca.crt
users:
- name: api-server
  user:
    client-certificate: /etc/kubernetes/pki/apiserver.crt
    client-key: /etc/kubernetes/pki/apiserver.key
contexts:
- name: default
  context:
    cluster: image-policy
    user: api-server
current-context: default
YAML

cat > /root/image-policy-notes.txt << 'NOTES'
defaultAllow: false means:
  - If the webhook is unreachable, all image pulls are DENIED
  - This is the secure choice — fail closed
  - May cause downtime if the webhook service goes down

defaultAllow: true means:
  - If the webhook is unreachable, all image pulls are ALLOWED
  - This is a security risk — an attacker could DoS the webhook to bypass validation
  - Only use this if availability is more critical than security

To enable ImagePolicyWebhook, add to API server flags:
  --enable-admission-plugins=...,ImagePolicyWebhook
  --admission-control-config-file=/etc/kubernetes/admission/image-policy.yaml
NOTES
