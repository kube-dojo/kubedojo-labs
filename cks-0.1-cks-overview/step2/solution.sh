#!/bin/bash
grep -oP '\-\-[a-z\-]+(auth|admission|audit|encrypt|tls|token|cert)[a-z\-]*' /etc/kubernetes/manifests/kube-apiserver.yaml | sort -u | head -10 > /root/security-flags.txt
grep -- '--authorization-mode' /etc/kubernetes/manifests/kube-apiserver.yaml | awk -F= '{print $2}' > /root/auth-modes.txt
grep -A1 'webhook:' /var/lib/kubelet/config.yaml | grep 'enabled:' | head -1 | awk '{print $2}' > /root/kubelet-auth.txt
