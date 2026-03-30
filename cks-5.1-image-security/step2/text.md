# Restrict Image Sources with Admission Control

Prevent pods from using images from untrusted registries.

## Task

1. Create an OPA/Gatekeeper-style constraint template concept document at `/root/image-policy.yaml` showing how you would:
   - Allow only images from `docker.io/library/` and `registry.k8s.io/`
   - Deny all other registries
2. Without an admission webhook, enforce a simpler check: create a script at `/root/check-images.sh` that:
   - Lists all pod images in the cluster
   - Flags any images NOT from approved registries
   - Outputs "COMPLIANT" or "NON-COMPLIANT" with details
3. Run the script and save output to `/root/image-compliance.txt`.
4. Create `/root/approved-registries.txt` listing registries you would allow in production.

## Hint

Use `kubectl get pods -A -o jsonpath='{range .items[*]}{.spec.containers[*].image}{"\n"}{end}'` to list all images.
