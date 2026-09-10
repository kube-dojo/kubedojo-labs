# Control Groups: Limit, Charge, Enforce

Namespaces control what a process can *see*; control groups control what it can *consume*. Every Kubernetes memory limit, every OOMKilled pod, and every mysteriously slow-but-not-crashed service reduces to files under `/sys/fs/cgroup`. If you can read and write those files directly, resource incidents stop being folklore and start being evidence.

This lab accompanies [Module 2.2: Control Groups (cgroups)](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.2-cgroups/) and practices its core workflow on the unified cgroup v2 hierarchy: **identify the hierarchy, set a limit, read the accounting, then watch the kernel enforce it**.

## Objectives

- Confirm the host runs cgroup v2 (`cgroup2fs`) and read your own shell's membership from `/proc/self/cgroup`.
- Create a cgroup with a hard 64 MiB `memory.max` ceiling.
- Move a process into the cgroup and read `memory.current` — the kernel's accounting, not the application's opinion.
- Cross the limit on purpose and collect real OOM-kill evidence: exit code 137 and the `memory.events` `oom_kill` counter.
- Cap CPU with `cpu.max` and prove throttling with `nr_throttled` and `throttled_usec` from `cpu.stat`.

Each step writes evidence into `/tmp/kd-cg/` and the verifier checks the **live kernel state** alongside it, so the files must reflect what actually happened. Commands that write cgroup files need `sudo`.
