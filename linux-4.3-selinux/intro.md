# SELinux Security Contexts

SELinux (Security-Enhanced Linux) is a mandatory access control (MAC) system developed by the NSA. It is the default MAC system on Red Hat, CentOS, Fedora, and Amazon Linux. While Ubuntu uses AppArmor by default, understanding SELinux is critical for Kubernetes administrators because many production clusters run on RHEL-based nodes.

SELinux assigns a **security context** (label) to every process, file, port, and user. Access decisions are made by comparing the source context against the target context using a policy database.

**Note**: This lab runs on Ubuntu, where SELinux is not the native MAC. We install the SELinux userspace tools (`policycoreutils`, `selinux-utils`) to explore concepts and commands. Full enforcement requires a SELinux-enabled kernel, which is standard on RHEL/CentOS but not on Ubuntu's Killercoda image. The exercises focus on understanding the tools and workflow rather than live enforcement.

## What You Will Learn

- SELinux modes (enforcing, permissive, disabled) and contexts
- File context management with `chcon` and `restorecon`
- Boolean policies with `getsebool` and `setsebool`
- Troubleshooting workflow with `ausearch` and `audit2allow`

## Prerequisites

- Familiarity with file permissions (Module 1.4)
- Basic understanding of AppArmor concepts (Module 4.2) is helpful for comparison

## Reference

This lab accompanies the KubeDojo curriculum module:
[Module 4.3 — SELinux](https://kube-dojo.github.io/linux/security/hardening/module-4.3-selinux/)
