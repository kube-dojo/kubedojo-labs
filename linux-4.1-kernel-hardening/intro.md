# Kernel Security Hardening

The Linux kernel exposes hundreds of tunable parameters that control networking behaviour, memory management, and security boundaries. Hardening these parameters is one of the first steps in securing any Linux host — and it is especially relevant in Kubernetes environments where nodes must resist lateral movement from compromised containers.

In this lab you will apply defence-in-depth at the kernel level: tuning sysctl parameters, restricting loadable kernel modules, setting up system call auditing, and inspecting boot-time security options.

## What You Will Learn

- Hardening network stack parameters with `sysctl`
- Persisting kernel parameter changes across reboots
- Blacklisting dangerous kernel modules via `modprobe`
- Auditing file access with `auditd` and `auditctl`
- Reading and interpreting `/proc/cmdline` boot parameters

## Prerequisites

- Familiarity with the Linux filesystem hierarchy (Module 1.3)
- Basic understanding of networking concepts (Module 3.1)

## Reference

This lab accompanies the KubeDojo curriculum module:
[Module 4.1 — Kernel Hardening](https://kube-dojo.github.io/linux/security/hardening/module-4.1-kernel-hardening/)
