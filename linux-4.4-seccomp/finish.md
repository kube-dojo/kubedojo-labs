# Congratulations!

You have completed the seccomp System Call Filtering lab.

## What You Practiced

- Inspecting seccomp status of running processes via `/proc/PID/status`
- Creating custom seccomp profiles in JSON format
- Understanding how profiles map to Docker `--security-opt` and Kubernetes `securityContext`

## Key Takeaway

seccomp is one of the three Linux security mechanisms that Kubernetes uses for container isolation (alongside namespaces and cgroups). The `RuntimeDefault` seccomp profile blocks approximately 44 dangerous syscalls. For CKS certification, you need to know how to create custom seccomp profiles and apply them via pod spec `securityContext.seccompProfile`.

## Next Steps

- Study the Docker default seccomp profile (blocks ~44 of ~300+ syscalls)
- Explore `strace` to discover which syscalls an application actually uses
- Investigate the `SeccompDefault` feature gate in Kubernetes (GA since 1.27)
- Learn about OCI runtime hooks that apply seccomp profiles automatically

## Reference

Full curriculum module:
[Module 4.4 — seccomp](https://kube-dojo.github.io/linux/security/hardening/module-4.4-seccomp/)
