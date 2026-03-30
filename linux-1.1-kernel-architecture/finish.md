## Lab Complete!

You've explored the Linux kernel internals:

- **Kernel info**: `uname -r`, `lsmod`, `modinfo` — version and loaded modules
- **/proc**: Virtual filesystem exposing kernel and process information
- **sysctl**: Runtime kernel parameters (ip_forward, network tuning)
- **dmesg**: Kernel ring buffer for boot and hardware messages

This knowledge is essential for Kubernetes: container runtimes depend on kernel features (namespaces, cgroups, overlay filesystems), and `sysctl` parameters affect pod networking.

### Next Steps

- **Next lab**: [Processes and systemd](https://killercoda.com/kubedojo/scenario/linux-1.2-processes-systemd) — deep dive into process states and systemd
- **Theory**: [Module 1.1: Kernel Architecture](https://kube-dojo.github.io/linux/foundations/system-essentials/module-1.1-kernel-architecture/) on KubeDojo
- **Track progress**: Mark this lab complete on your [KubeDojo dashboard](https://kube-dojo.github.io/)
