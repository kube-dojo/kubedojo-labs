#!/bin/bash
trivy image nginx:1.19 > /root/trivy-nginx-old.txt 2>&1
trivy image nginx:latest > /root/trivy-nginx-latest.txt 2>&1
trivy image --severity CRITICAL nginx:1.19 2>/dev/null | grep -c "CRITICAL" > /root/critical-count.txt || echo "0" > /root/critical-count.txt
trivy image -f json nginx:1.19 > /root/trivy-report.json 2>/dev/null
