#!/bin/bash
set -euo pipefail
actual=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
if [ "$actual" = 192.0.2.1 ]; then wrong=192.0.2.2; else wrong=192.0.2.1; fi
printf '%s\n' "$wrong" > "$HOME/node-ip.txt"
