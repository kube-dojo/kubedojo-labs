# Congratulations!

You have completed the **Security Contexts** lab.

## Key Takeaways

- Always set `runAsNonRoot: true` and specify `runAsUser`
- `readOnlyRootFilesystem` prevents filesystem modifications
- `allowPrivilegeEscalation: false` blocks setuid/capability escalation
- Pod-level context applies to all containers; container-level overrides

## What's Next

Continue to the next lab: [CKS 4.2: Pod Security Admission](https://killercoda.com/kubedojo/scenario/cks-4.2-pod-security-admission)

> **Study more**: [KubeDojo Security Contexts](https://kube-dojo.github.io/k8s/cks/part4/module-4.1-security-contexts/)
