#!/bin/bash
kubectl create configmap app-config --from-literal=APP_ENV=production --from-literal=LOG_LEVEL=info -n cm-lab
kubectl create configmap file-config --from-file="$HOME"/app.properties -n cm-lab
kubectl get configmap app-config -n cm-lab -o jsonpath='{.data}' > "$HOME"/cm-data.txt
