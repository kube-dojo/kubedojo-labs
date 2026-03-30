#!/bin/bash
kubectl create role pod-reader --verb=get,list,watch --resource=pods -n exam-practice
kubectl create rolebinding exam-sa-binding --role=pod-reader --serviceaccount=exam-practice:exam-sa -n exam-practice
cat <<YAML | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
  namespace: exam-practice
spec:
  podSelector: {}
  policyTypes:
  - Ingress
YAML
kubectl auth can-i list pods -n exam-practice --as=system:serviceaccount:exam-practice:exam-sa > /root/rbac-check.txt
