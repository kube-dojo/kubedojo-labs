#!/bin/bash
set -euo pipefail
kubectl expose deployment web --name=web-svc --port=80 --target-port=80
kubectl patch service web-svc -p '{"spec":{"selector":{"app":"wrong"}}}'
