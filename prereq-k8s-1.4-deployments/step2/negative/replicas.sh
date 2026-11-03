#!/bin/bash
set -euo pipefail
kubectl scale deployment webapp --replicas=4
