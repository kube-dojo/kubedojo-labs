#!/bin/bash
kubectl --v=8 get pods -n kube-system 1>/dev/null 2>/var/tmp/cka-1.1-kubectl-trace.log
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
  get /registry/pods/kube-system --prefix --keys-only >> /var/tmp/cka-1.1-kubectl-trace.log
echo "Trace written to /var/tmp/cka-1.1-kubectl-trace.log"
sed -n '1,20p' /var/tmp/cka-1.1-kubectl-trace.log
