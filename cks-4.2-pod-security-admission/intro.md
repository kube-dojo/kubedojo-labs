# Pod Security Admission

Pod Security Admission (PSA) enforces Pod Security Standards at the namespace level. It replaces the deprecated PodSecurityPolicy.

## Three Levels

- **Privileged**: No restrictions (unrestricted)
- **Baseline**: Prevents known privilege escalations
- **Restricted**: Heavily restricted, following security best practices

## Three Modes

- **enforce**: Reject pods that violate the policy
- **warn**: Allow but warn on violations
- **audit**: Allow but log violations in audit log

> **Study guide**: [KubeDojo Pod Security Admission](https://kube-dojo.github.io/k8s/cks/part4/module-4.2-pod-security-admission/)
