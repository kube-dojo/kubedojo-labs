## Processes and systemd Deep Dive

Building on the basics, this lab dives deeper into process states, systemd internals, and the cgroup mechanism that powers Kubernetes resource limits.

### What You'll Learn

- Understand Linux process states: Running, Sleeping, Zombie, Stopped
- Explore systemd unit types: services, timers, sockets, targets
- Map systemd dependencies
- Inspect cgroups v2 controllers

### Before You Start

If you haven't read the theory yet, check out [Module 1.2: Processes and systemd](https://kube-dojo.github.io/linux/foundations/system-essentials/module-1.2-processes-systemd/) on KubeDojo.

This lab takes about **35 minutes**. Let's go!
