#!/bin/bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
echo "bitnami/nginx" > /root/nginx-chart.txt
echo "Chart name saved:"
cat /root/nginx-chart.txt
echo ""
echo "Search results:"
helm search repo bitnami/nginx
