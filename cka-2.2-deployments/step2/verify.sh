#!/bin/bash
# Verify: at least 3 revisions in rollout history
REVISIONS=$(kubectl rollout history deployment/web-deploy -n practice 2>/dev/null | grep -c "^[0-9]")
[ "$REVISIONS" -ge 3 ] && exit 0 || exit 1
