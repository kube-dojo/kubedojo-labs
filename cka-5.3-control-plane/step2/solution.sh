#!/bin/bash
cp /etc/kubernetes/manifests/kube-apiserver.yaml /root/kube-apiserver-backup.yaml
grep -E "^\s+--" /etc/kubernetes/manifests/kube-apiserver.yaml > /root/apiserver-config.txt
cat /root/apiserver-config.txt | head -10
