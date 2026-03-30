#!/bin/bash
kubectl exec test-pod -n metadata-lab -- curl -s --connect-timeout 3 http://169.254.169.254/ > /root/metadata-test-after.txt 2>&1 || echo "Connection blocked by NetworkPolicy" > /root/metadata-test-after.txt
cat > /root/metadata-controls.txt << 'CONTROLS'
NetworkPolicy: block-metadata in metadata-lab namespace
Blocked IP: 169.254.169.254/32
Importance: Prevents pods from accessing cloud instance metadata which may contain IAM credentials
Alternatives:
- AWS IMDSv2 (requires hop limit = 1, blocking container access)
- GCP Workload Identity (replaces node-level credentials)
- Azure Pod Identity / Workload Identity
- Setting metadata hop limit to 1 at the cloud provider level
CONTROLS
