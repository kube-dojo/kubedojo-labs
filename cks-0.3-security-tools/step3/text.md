# Analyze Pod Manifests with kubesec

kubesec performs static analysis on Kubernetes manifests to identify security risks.

## Task

1. Create a pod manifest at `"$HOME"/test-pod.yaml` for a pod named `test-pod` using image `nginx` with no security context.
2. Run kubesec against it: `kubesec scan "$HOME"/test-pod.yaml` and save the output to `"$HOME"/kubesec-results.json`.
3. Create an improved manifest at `"$HOME"/secure-pod.yaml` that addresses kubesec findings:
   - Add `runAsNonRoot: true`
   - Add `readOnlyRootFilesystem: true`
   - Add `runAsUser: 1000`
   - Drop ALL capabilities
4. Run kubesec on the improved manifest and save to `"$HOME"/kubesec-secure.json`. The score should be higher.

## Hint

kubesec outputs JSON with a `score` field. Compare the scores of both manifests.
