#!/bin/bash
kubectl create namespace psa-transition 2>/dev/null || true
kubectl label namespace psa-transition \
  pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/warn=restricted \
  pod-security.kubernetes.io/audit=restricted --overwrite

kubectl run warn-test --image=nginx -n psa-transition > /root/psa-warnings.txt 2>&1 || true
kubectl wait --for=condition=Ready pod/warn-test -n psa-transition --timeout=60s 2>/dev/null || true

cat > /root/psa-migration-plan.txt << 'PLAN'
Migration from Baseline to Restricted:

Step 1 — Observe (1-2 weeks):
  - Label namespace with warn=restricted and audit=restricted
  - Keep enforce=baseline (no disruption)
  - Review audit logs and kubectl warnings for violations

Step 2 — Remediate (as needed):
  - Fix each workload to comply with restricted standard
  - Add runAsNonRoot, seccomp, drop ALL caps, etc.
  - Test in staging environment first

Step 3 — Enforce (once all workloads comply):
  - Change enforce label to restricted
  - Monitor for any blocked deployments
  - Keep warn and audit for ongoing monitoring
PLAN
