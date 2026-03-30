#!/bin/bash
grep "listen-client-urls" /etc/kubernetes/manifests/etcd.yaml | awk -F'=' '{print $2}' | tr -d ' ' > /root/etcd-endpoint.txt
echo "etcd endpoint:"
cat /root/etcd-endpoint.txt
