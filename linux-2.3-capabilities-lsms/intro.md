# Capabilities & LSMs: Audit, Grant, Drop, Diagnose

"Root" is not one thing. Linux splits the old all-powerful UID 0 into ~40 named capabilities, and container runtimes hand workloads only a subset. On top of that, Linux Security Modules and seccomp add mandatory checks that apply even when permissions and capabilities would allow an action. Every `operation not permitted` you will ever debug comes from one of these layers — and the fix is different for each.

This lab accompanies [Module 2.3: Capabilities & Linux Security Modules](https://kube-dojo.github.io/linux/foundations/container-primitives/module-2.3-capabilities-lsms/) and practices its core discipline: **debug by layer, not by guesswork**.

## Objectives

- Read your process capability sets from `/proc/self/status` and decode the hex masks with `capsh`.
- Attach `cap_net_bind_service` to a binary with `setcap` and prove a non-root user can then bind a privileged port — the safer replacement for setuid-root.
- Drop `cap_chown` with `capsh --drop` and watch the *same operation that just succeeded* fail with `Operation not permitted`, even as root.
- Diagnose the live LSM stack from `/sys/kernel/security/lsm` and `aa-status` — a missing module is a finding, not a failure.
- Enforce a real seccomp filter through a transient systemd unit and prove the kernel blocks the denied syscall.

Each step writes evidence into `/tmp/kd-caps/`; the verifier cross-checks it against **live kernel state** (file capabilities are re-read, the test binary is re-executed, ownership is re-stat'ed), so the evidence must reflect what actually happened. Privileged writes need `sudo`.
