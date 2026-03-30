# Congratulations!

You have completed the Kernel Security Hardening lab.

## What You Practiced

- Tuning kernel parameters with `sysctl` to harden the network stack
- Persisting security-critical sysctl settings in `/etc/sysctl.d/`
- Blacklisting unnecessary kernel modules to reduce attack surface
- Configuring `auditd` rules to monitor sensitive file access
- Inspecting boot parameters for security-relevant kernel options

## Key Takeaway

Kubernetes nodes are only as secure as their underlying kernel configuration. CIS benchmarks for Kubernetes require many of these same sysctl hardening steps on every node. In production, tools like Ansible, Puppet, or DaemonSets with `initContainers` enforce these settings at scale.

## Next Steps

- Study the CIS Benchmark for Ubuntu Linux — it codifies hundreds of kernel hardening rules
- Explore how Kubernetes `SecurityContext` and `PodSecurityStandards` enforce sysctl restrictions at the pod level
- Investigate `kube-bench` which automates CIS benchmark checks on Kubernetes nodes

## Reference

Full curriculum module:
[Module 4.1 — Kernel Hardening](https://kube-dojo.github.io/linux/security/hardening/module-4.1-kernel-hardening/)
