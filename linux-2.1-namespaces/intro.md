# Linux Namespaces: Inspect, Create, Enter

Containers are ordinary Linux processes with carefully selected namespace memberships. A namespace gives a process a scoped view of one global resource: its own process tree, its own network stack, its own mount table. If you can inspect those boundaries directly, container behavior stops feeling magical and starts becoming debuggable.

This lab accompanies [Module 2.1: Linux Namespaces](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.1-namespaces/) and practices its core workflow: **compare first, enter second**.

## Objectives

- Read namespace membership from `/proc/<pid>/ns` and compare two processes.
- Create an isolated PID namespace with `unshare --pid --fork --mount-proc` and prove the process view shrank.
- Create a named network namespace with `ip netns`, bring loopback up, and understand why the namespace starts lonely.
- Enter a namespace with `nsenter` to run host tools against an isolated network stack.
- Prove that a mount made inside a mount namespace is invisible to the host.

Each step writes evidence into `/tmp/kd-ns/` so the verifier can check the actual namespace state, not just command history. Work as the user you are logged in as; commands that create namespaces need `sudo`.
