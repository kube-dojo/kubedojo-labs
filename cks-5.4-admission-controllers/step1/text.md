# Understand Built-in Admission Controllers

Review which admission controllers are enabled and their security impact.

## Task

1. List the currently enabled admission plugins from the API server manifest. Save to `/root/enabled-plugins.txt`.
2. Create `/root/security-plugins.txt` documenting these security-relevant admission controllers:
   - AlwaysPullImages
   - DenyServiceExternalIPs
   - NodeRestriction
   - PodSecurity
   - ServiceAccount
3. Check if `AlwaysPullImages` is enabled. Save "enabled" or "disabled" to `/root/always-pull-status.txt`.
4. Explain in `/root/admission-flow.txt` the order: Authentication -> Authorization -> Mutating Admission -> Validating Admission -> Persistence.

## Hint

Check `--enable-admission-plugins` in `/etc/kubernetes/manifests/kube-apiserver.yaml`. Some controllers are enabled by default even without being listed.
