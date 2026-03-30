# Test Enforcement of Restricted Standard

The restricted standard requires specific security contexts. Test creating compliant and non-compliant pods.

## Task

1. Create a **compliant** pod named `restricted-ok` in `psa-restricted` with all required security settings:
   - `runAsNonRoot: true`, `runAsUser: 1000`
   - `seccompProfile.type: RuntimeDefault`
   - `allowPrivilegeEscalation: false`
   - `capabilities.drop: ["ALL"]`
   - Image: `busybox`, command: `["sleep", "3600"]`
2. Verify the pod starts successfully. Save its status to `/root/restricted-ok.txt`.
3. Try creating a **non-compliant** pod named `restricted-fail` in `psa-restricted` with just `image: nginx` (no security context). Save the error to `/root/restricted-fail.txt`.
4. Document the requirements of the restricted standard in `/root/restricted-requirements.txt`.

## Hint

The restricted standard requires: runAsNonRoot, seccomp RuntimeDefault or Localhost, no privilege escalation, drop ALL capabilities, no host namespaces/ports.
