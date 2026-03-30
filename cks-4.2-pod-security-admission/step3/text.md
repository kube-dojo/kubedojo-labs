# Configure Warn and Audit Modes

Use warn and audit modes to discover violations without blocking workloads.

## Task

1. Create a namespace `psa-transition` with:
   - `enforce: baseline` (block dangerous)
   - `warn: restricted` (warn on non-restricted)
   - `audit: restricted` (log non-restricted)
2. Deploy a pod with `image: nginx` (no security context) in `psa-transition`. It should succeed (passes baseline) but show warnings. Save the output including warnings to `/root/psa-warnings.txt`.
3. Create `/root/psa-migration-plan.txt` documenting a plan to migrate from baseline to restricted:
   - Step 1: Add warn=restricted to see violations
   - Step 2: Fix workloads to be restricted-compliant
   - Step 3: Switch enforce to restricted

## Hint

Use `kubectl label` with all three modes. Warnings appear in the kubectl output as `Warning:` lines.
