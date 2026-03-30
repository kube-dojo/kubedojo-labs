# Analyze Pod Manifests with kubesec

kubesec performs static analysis on Kubernetes manifests to identify security risks.

## Task

1. Create a pod manifest at `/root/test-pod.yaml` for a pod named `test-pod` using image `nginx` with no security context.
2. Run kubesec against it: `kubesec scan /root/test-pod.yaml` and save the output to `/root/kubesec-results.json`.
3. Create an improved manifest at `/root/secure-pod.yaml` that addresses kubesec findings:
   - Add `runAsNonRoot: true`
   - Add `readOnlyRootFilesystem: true`
   - Add `runAsUser: 1000`
   - Drop ALL capabilities
4. Run kubesec on the improved manifest and save to `/root/kubesec-secure.json`. The score should be higher.

## Hint

kubesec outputs JSON with a `score` field. Compare the scores of both manifests.
