#!/bin/bash
trivy image nginx:1.19 > /root/scan-nginx-old.txt 2>&1
trivy image nginx:latest > /root/scan-nginx-new.txt 2>&1
trivy image --severity CRITICAL,HIGH nginx:1.19 > /root/scan-critical.txt 2>&1
trivy image -f json nginx:1.19 > /root/scan-report.json 2>/dev/null
