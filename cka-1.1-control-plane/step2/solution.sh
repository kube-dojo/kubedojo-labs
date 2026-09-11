#!/bin/bash
sudo grep "listen-client-urls" /etc/kubernetes/manifests/etcd.yaml | awk -F'=' '{print $2}' | tr -d ' ' > "$HOME"/etcd-endpoint.txt
echo "etcd endpoint:"
cat "$HOME"/etcd-endpoint.txt
