# ServiceAccount Security

Every pod runs as a ServiceAccount. Securing ServiceAccounts prevents lateral movement and privilege escalation in compromised containers.

## What You Will Learn

- Disable automatic token mounting for pods that do not need API access
- Use short-lived projected tokens instead of long-lived secrets
- Audit ServiceAccount permissions across the cluster

> **Study guide**: [KubeDojo ServiceAccount Security](https://kube-dojo.github.io/k8s/cks/part2/module-2.2-serviceaccount-security/)
