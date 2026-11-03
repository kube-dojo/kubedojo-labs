#!/bin/bash
set -euo pipefail
kubectl create deployment webapp --image=nginx:1.25 --replicas=2
