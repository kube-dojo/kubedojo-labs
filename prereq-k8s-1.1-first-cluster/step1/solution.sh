#!/bin/bash
kubectl get nodes -o jsonpath='{.items[0].metadata.name}' > /root/node-name.txt
