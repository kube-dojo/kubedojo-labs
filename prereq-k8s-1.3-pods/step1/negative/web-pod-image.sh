#!/bin/bash
set -euo pipefail
kubectl run web --image=nginx:1.26
