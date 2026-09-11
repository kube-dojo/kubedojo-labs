# Analyze Manifests with kubesec

kubesec scores Kubernetes manifests and provides actionable security feedback.

## Task

1. Create three pod manifests with varying security levels:
   - `"$HOME"/pod-insecure.yaml`: nginx with no security context
   - `"$HOME"/pod-baseline.yaml`: nginx with `runAsNonRoot: true`
   - `"$HOME"/pod-hardened.yaml`: nginx with full security (runAsNonRoot, readOnlyRootFilesystem, drop ALL caps, allowPrivilegeEscalation: false, seccomp RuntimeDefault)
2. Scan each with kubesec and save results to `"$HOME"/kubesec-insecure.json`, `"$HOME"/kubesec-baseline.json`, `"$HOME"/kubesec-hardened.json`.
3. Compare the scores and save a summary to `"$HOME"/kubesec-scores.txt`.

## Hint

kubesec outputs JSON with a `score` field. Higher scores indicate better security. The scoring is based on presence of security controls.
