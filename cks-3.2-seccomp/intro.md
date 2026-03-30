# Seccomp Profiles

Seccomp (Secure Computing Mode) restricts the system calls a process can make. Kubernetes supports applying seccomp profiles to containers.

## What You Will Learn

- Apply the RuntimeDefault seccomp profile to pods
- Create custom seccomp profiles with allowed syscall lists
- Understand the difference between Unconfined, RuntimeDefault, and Localhost profiles

> **Study guide**: [KubeDojo Seccomp](https://kube-dojo.github.io/k8s/cks/part3/module-3.2-seccomp/)
