# Well Done

You practiced the namespace debugging workflow senior engineers actually use:

- **Compared** namespace identities through `/proc/<pid>/ns` before touching anything.
- **Created** PID, network, and mount namespaces with `unshare` and `ip netns`, and saw why `--fork` and `--mount-proc` matter.
- **Entered** a network namespace with `nsenter` to run host tools against an isolated stack — the exact move that saves you when a minimal image has no debugging tools.
- **Proved** that a mount made inside a namespace is invisible outside it — the reason same-pod containers need shared volumes for shared files.

Clean up if you want to rerun: `sudo ip netns delete lab-net` and `sudo rm -rf /tmp/kd-ns`.

## Next

Return to [Module 2.1: Linux Namespaces](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.1-namespaces/) for the Kubernetes pod namespace layout and the full decision framework, then continue to [Module 2.2: Control Groups](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.2-cgroups/) — namespaces control what a process can *see*; cgroups control what it can *consume*.
