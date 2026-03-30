# Deploy a Vulnerable Application for Testing

Deploy intentionally insecure workloads to practice identifying and fixing security issues.

## Task

1. Create a deployment named `vuln-app` in the `security-lab` namespace with:
   - Image: `nginx:1.19` (intentionally old)
   - 1 replica
   - Container running as root (runAsUser: 0)
   - Privileged mode enabled
2. Create a second deployment named `hardened-app` in the `security-lab` namespace with:
   - Image: `nginx:latest`
   - 1 replica
   - runAsNonRoot: true, runAsUser: 1000
   - readOnlyRootFilesystem: true
   - allowPrivilegeEscalation: false
   - Drop ALL capabilities
3. Wait for both deployments to be available.

## Hint

Use `kubectl create deployment` and then `kubectl patch` for security contexts, or write YAML manifests directly.
