#!/bin/bash
kubectl create secret generic db-creds --from-literal=username=admin --from-literal=password=s3cur3P@ss -n secrets-lab
kubectl get secret db-creds -n secrets-lab -o jsonpath='{.data.password}' | base64 -d > /root/decoded-password.txt
kubectl get secret db-creds -n secrets-lab -o jsonpath='{.type}' > /root/secret-type.txt
