#!/bin/bash
cp /var/tmp/cka-1.1-kube-scheduler.yaml.backup /etc/kubernetes/manifests/kube-scheduler.yaml
echo "Restored scheduler manifest. Check progress with:"
echo "  kubectl get pod scheduler-smoke -n practice -o wide"
echo "  kubectl get pods -n kube-system -l component=kube-scheduler"
