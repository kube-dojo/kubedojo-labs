# Identify Common Security Anti-Patterns

Learn to spot security issues in Kubernetes manifests by reviewing examples.

## Task

1. Create `"$HOME"/antipatterns.yaml` with a deployment that has at least 5 security anti-patterns (e.g., privileged, hostNetwork, no resource limits, latest tag, hostPath).
2. Create `"$HOME"/antipatterns-list.txt` identifying each anti-pattern and explaining why it is dangerous.
3. Create `"$HOME"/antipatterns-fixed.yaml` with the corrected version of the same deployment.
4. Scan both with kubesec and compare scores in `"$HOME"/antipattern-scores.txt`.

## Hint

Common anti-patterns: `privileged: true`, `hostNetwork: true`, `hostPID: true`, `image: nginx:latest`, `hostPath` volumes, no resource limits, running as root.
