# Node Metadata Protection

Cloud provider metadata endpoints (e.g., 169.254.169.254) expose sensitive data like IAM credentials. Pods should be blocked from accessing these endpoints.

## What You Will Learn

- The cloud metadata attack vector (SSRF, credential theft)
- Block metadata access using NetworkPolicies with ipBlock
- Verify that pods cannot reach metadata endpoints

> **Study guide**: [KubeDojo Node Metadata](https://kube-dojo.github.io/k8s/cks/part1/module-1.4-node-metadata/)
