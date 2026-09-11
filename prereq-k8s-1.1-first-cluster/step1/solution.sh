#!/bin/bash
kubectl get nodes -o jsonpath='{.items[0].metadata.name}' > "$HOME"/node-name.txt
