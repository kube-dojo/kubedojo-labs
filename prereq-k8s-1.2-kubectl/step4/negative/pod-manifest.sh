#!/bin/bash
set -euo pipefail
printf '# kind: Pod\n# name: nginx\n# image: nginx:1.25\nnot: [yaml\n' > "$HOME/nginx-pod.yaml"
