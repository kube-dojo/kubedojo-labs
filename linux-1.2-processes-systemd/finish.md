## Lab Complete!

You've gone deep into processes and systemd:

- **Process states**: R (running), S (sleeping), D (disk wait), Z (zombie), T (stopped)
- **Unit types**: services, timers, sockets, targets — systemd manages them all
- **Dependencies**: `Wants`, `Requires`, `After` — the boot dependency graph
- **cgroups v2**: The resource control mechanism behind Kubernetes pods

Kubernetes resource requests and limits map directly to cgroup constraints. Understanding this connection helps you debug OOMKills and CPU throttling.

### Next Steps

- **Next lab**: [Filesystem Hierarchy](https://killercoda.com/kubedojo/scenario/linux-1.3-filesystem-hierarchy) — FHS, finding files, disk management
- **Theory**: [Module 1.2: Processes and systemd](https://kube-dojo.github.io/linux/foundations/system-essentials/module-1.2-processes-systemd/) on KubeDojo
- **Track progress**: Mark this lab complete on your [KubeDojo dashboard](https://kube-dojo.github.io/)
