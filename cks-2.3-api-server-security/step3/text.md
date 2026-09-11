# Enable and Verify Admission Controllers

Admission controllers intercept API requests before persistence. Several are security-critical.

## Task

1. Extract the current `--enable-admission-plugins` value and save to `"$HOME"/admission-plugins.txt`.
2. Verify that these security-critical admission controllers are enabled:
   - `NodeRestriction`
   - `PodSecurity` (or `PodSecurityPolicy` in older versions)
   Save the compliance status to `"$HOME"/admission-check.txt`.
3. List the default admission controllers that are always enabled and save to `"$HOME"/default-admission.txt` (check the Kubernetes docs or `kube-apiserver -h`).
4. Create `"$HOME"/admission-security.txt` explaining the security role of: NodeRestriction, PodSecurity, and AlwaysPullImages.

## Hint

Use `kubectl exec` on the API server pod or check the manifest. `NodeRestriction` limits what kubelets can modify.
