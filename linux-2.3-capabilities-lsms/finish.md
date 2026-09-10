# Well Done

You practiced the layered privilege model the way security reviews actually work:

- **Audited** capability sets from `/proc/self/status` and decoded the masks with `capsh` — the first stop when a "root" process mysteriously can't do something.
- **Granted** exactly one power with `setcap cap_net_bind_service=+ep`: a non-root user bound a privileged port without becoming root. You also saw the trap: file capabilities are silently ignored on `nosuid` mounts.
- **Dropped** `cap_chown` and watched the same `chown` that just worked fail with `Operation not permitted` — proof that capability checks are independent of UID 0.
- **Diagnosed** the live LSM stack instead of assuming it: `/sys/kernel/security/lsm` and `aa-status` tell you which mandatory layer can even be in play on this host.
- **Enforced** a seccomp filter through a transient systemd unit and proved the kernel rejects the denied syscall while the unfiltered control succeeds.

Clean up if you want to rerun: `sudo rm -rf /tmp/kd-caps /opt/kd-caps`, or just re-run the setup.

## Next

Return to [Module 2.3: Capabilities & LSMs](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.3-capabilities-lsms/) for the Kubernetes securityContext mapping and the decision framework, then continue to [Module 2.4: Union Filesystems](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.4-union-filesystems/) — after what a process may see, consume, and do, the last primitive is how container images stack read-only layers into one filesystem.
