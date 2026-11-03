#!/bin/bash
set -euo pipefail
kubectl expose deployment web --name=web-nodeport --port=80 --type=ClusterIP
