#!/bin/bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install web-app bitnami/nginx -n helm-lab
helm list -n helm-lab > /root/helm-releases.txt
