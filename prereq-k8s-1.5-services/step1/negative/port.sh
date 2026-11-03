#!/bin/bash
set -euo pipefail
kubectl expose deployment web --name=web-svc --port=81 --target-port=80
