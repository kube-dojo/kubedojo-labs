#!/bin/bash
set -euo pipefail
printf 'not: [valid yaml\n# image: nginx:1.25\n' > "$HOME/pod-spec.yaml"
