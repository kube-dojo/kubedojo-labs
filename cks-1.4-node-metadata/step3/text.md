# Verify Metadata Protection and Document Controls

Verify the NetworkPolicy is effective and document the security control.

## Task

1. Test metadata access from `test-pod` again and save to `/root/metadata-test-after.txt`.
2. Create `/root/metadata-controls.txt` documenting:
   - The NetworkPolicy name and namespace
   - What IP is blocked
   - Why this control is important (one sentence)
   - Alternative controls (e.g., cloud provider metadata hop limit, IMDSv2)

## Hint

The test should show the metadata endpoint is now unreachable. Document both Kubernetes-level and cloud-provider-level controls.
