# Apply Pod Security Standards to Namespaces

Label namespaces to enforce Pod Security Standards.

## Task

1. Create three namespaces: `psa-privileged`, `psa-baseline`, `psa-restricted`.
2. Label each namespace with the appropriate Pod Security Standard:
   - `psa-privileged`: enforce privileged
   - `psa-baseline`: enforce baseline
   - `psa-restricted`: enforce restricted
3. Save the labels of each namespace to `/root/psa-labels.txt`.
4. Try deploying a privileged pod in each namespace and record which succeed/fail in `/root/psa-deployment-test.txt`.

## Hint

Use `kubectl label namespace psa-restricted pod-security.kubernetes.io/enforce=restricted`. The label format is `pod-security.kubernetes.io/<mode>=<level>`.
