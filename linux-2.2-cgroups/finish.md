# Well Done

You worked the cgroup evidence chain the way a node incident is actually diagnosed:

- **Identified** the hierarchy first — `cgroup2fs` and your own `/proc/self/cgroup` line — because every later path depends on the version.
- **Created** a cgroup and wrote a hard `memory.max` ceiling, the same file a Kubernetes memory limit ultimately becomes.
- **Charged** memory to the group and read `memory.current`: kernel accounting covers the whole process footprint, not just an application heap.
- **Crossed** the limit and collected real enforcement evidence — `SIGKILL` (exit 137) plus the `memory.events` `oom_kill` counter. No exception, no final log line: that is why OOMKilled pods have empty application logs.
- **Throttled** CPU with `cpu.max` and proved it with `nr_throttled`/`throttled_usec` — the counters that explain "slow service, idle node".

Clean up if you want to rerun: `sudo rmdir /sys/fs/cgroup/kd-lab` (after its processes exit) and `sudo rm -rf /tmp/kd-cg`, or just re-run the setup.

## Next

Return to [Module 2.2: Control Groups (cgroups)](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.2-cgroups/) for the Kubernetes requests/limits/QoS mapping and the decision framework, then continue to [Module 2.3: Capabilities & LSMs](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.3-capabilities-lsms/) — cgroups constrain how much a process consumes; capabilities constrain what it may *do*.
