#!/bin/bash
kubectl patch svc web-svc -n practice --type='json' -p='[{"op":"replace","path":"/spec/ports/0/targetPort","value":80}]'
sleep 2
kubectl get svc web-svc -n practice
