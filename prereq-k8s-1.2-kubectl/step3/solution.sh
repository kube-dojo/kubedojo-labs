#!/bin/bash
kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' > "$HOME"/node-ip.txt
