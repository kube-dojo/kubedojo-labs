# seccomp System Call Filtering

seccomp (secure computing mode) is a Linux kernel feature that restricts which system calls a process can make. It is a critical security primitive — by limiting the syscall surface, you reduce the attack surface available to an exploited process.

Container runtimes (Docker, containerd, CRI-O) apply default seccomp profiles that block dangerous syscalls like `reboot`, `mount`, and `kexec_load`. Kubernetes supports custom seccomp profiles through the pod security context, and the `RuntimeDefault` profile is recommended as a baseline.

## What You Will Learn

- How seccomp works at the kernel level
- Reading seccomp status from `/proc/PID/status`
- Writing seccomp profiles in JSON format
- Applying profiles to Docker containers and Kubernetes pods

## Prerequisites

- Understanding of processes and PIDs (Module 1.2)
- Familiarity with JSON format

## Reference

This lab accompanies the KubeDojo curriculum module:
[Module 4.4 — seccomp](https://kube-dojo.github.io/linux/security/hardening/module-4.4-seccomp/)
