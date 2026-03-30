# Understand the Metadata Endpoint Threat

Cloud provider metadata services expose instance credentials and configuration at well-known IP addresses.

## Task

1. Document the metadata endpoint IPs for the three major cloud providers. Create `/root/metadata-endpoints.txt` with:
   - AWS: `169.254.169.254`
   - GCP: `metadata.google.internal` (169.254.169.254)
   - Azure: `169.254.169.254`
2. From the `test-pod` in `metadata-lab`, attempt to reach `169.254.169.254` and save the result to `/root/metadata-test-before.txt` (should timeout in a non-cloud environment).
3. Save the pod's node name to `/root/pod-node.txt`.

## Hint

Use `kubectl exec test-pod -n metadata-lab -- curl -s --connect-timeout 3 http://169.254.169.254/` to test metadata access.
