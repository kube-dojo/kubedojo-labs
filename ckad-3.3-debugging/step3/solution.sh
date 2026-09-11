#!/bin/bash
kubectl run debug-target --image=nginx:1.25 -n debug-lab
kubectl wait --for=condition=Ready pod/debug-target -n debug-lab --timeout=60s
kubectl exec debug-target -n debug-lab -- nginx -v 2>&1 > "$HOME"/nginx-version.txt
kubectl exec debug-target -n debug-lab -- ls /etc/nginx/ > "$HOME"/nginx-config-list.txt
kubectl exec debug-target -n debug-lab -- cat /etc/resolv.conf | grep nameserver > "$HOME"/dns-server.txt
