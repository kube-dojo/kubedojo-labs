# Immutable Container Infrastructure

Immutable containers cannot be modified at runtime — no file writes, no package installs, no configuration changes. This prevents attackers from tampering with running workloads.

## What You Will Learn

- Configure readOnlyRootFilesystem for true immutability
- Use emptyDir volumes for minimal writable space
- Enforce immutability cluster-wide with admission policies
- Audit existing workloads for immutability compliance

> **Study guide**: [KubeDojo Immutable Infrastructure](https://kube-dojo.github.io/k8s/cks/part6/module-6.4-immutable-infrastructure/)
