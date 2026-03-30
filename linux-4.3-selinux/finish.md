# Congratulations!

You have completed the SELinux Security Contexts lab.

## What You Practiced

- Installing and inspecting SELinux userspace tools on Ubuntu
- Understanding SELinux modes, contexts, and label format
- Working with file contexts using `chcon` and `restorecon`
- Exploring SELinux boolean policies
- Documenting the SELinux troubleshooting workflow

## Key Takeaway

While this lab ran on Ubuntu without full SELinux enforcement, the concepts and commands transfer directly to RHEL-based Kubernetes nodes. On production EKS (Amazon Linux), GKE (Container-Optimized OS), and OpenShift (RHEL) clusters, SELinux is often enforcing by default. Knowing how to read contexts, toggle booleans, and troubleshoot denials is essential for CKS certification and real-world cluster operations.

## Next Steps

- Practice on a RHEL/CentOS/Fedora system where SELinux enforces by default
- Study how OpenShift uses SELinux with its Security Context Constraints (SCCs)
- Compare SELinux and AppArmor approaches to container isolation
- Explore `udica` — a tool that generates SELinux policies for containers

## Reference

Full curriculum module:
[Module 4.3 — SELinux](https://kube-dojo.github.io/linux/security/hardening/module-4.3-selinux/)
