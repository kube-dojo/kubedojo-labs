#!/bin/bash
set -euo pipefail
kubectl create deployment webapp --image=nginx:1.26 --replicas=3
