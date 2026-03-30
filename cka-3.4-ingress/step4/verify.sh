#!/bin/bash
# Verify: TLS secret and TLS ingress exist
SECRET=$(kubectl get secret tls-secret -n practice -o jsonpath='{.type}' 2>/dev/null)
TLS_HOST=$(kubectl get ingress tls-ingress -n practice -o jsonpath='{.spec.tls[0].hosts[0]}' 2>/dev/null)
[ "$SECRET" = "kubernetes.io/tls" ] && [ "$TLS_HOST" = "secure.example.com" ] && exit 0 || exit 1
