# Diagnose the LSM Stack

Capabilities are only the middle layer. Linux Security Modules add mandatory policy *after* permissions and capability checks: AppArmor (path-based, Ubuntu/Debian), SELinux (label-based, RHEL family), plus stacked minor LSMs like Yama or Landlock. Before you blame a profile — or trust one — check what the kernel actually loaded. A profile referenced in a manifest protects nothing on a node whose kernel never enabled that LSM. A missing module is a **finding**, not a failed exercise.

## Task

1. Record the kernel's live LSM list (`/sys/kernel/security/lsm`) into `/tmp/kd-caps/lsm.txt`.
2. Capture `aa-status` output (or its failure message, if AppArmor is absent) into `/tmp/kd-caps/aa-status.txt`.
3. Write your conclusion — exactly `yes` or `no` — into `/tmp/kd-caps/apparmor-active.txt`: is AppArmor part of this host's active LSM stack?

The verifier compares your conclusion against the live LSM list, so answer from the evidence, not from what the distribution "usually" ships.

<details>
<summary>Hint</summary>

```bash
cat /sys/kernel/security/lsm > /tmp/kd-caps/lsm.txt
sudo aa-status > /tmp/kd-caps/aa-status.txt 2>&1 || true
if grep -qw apparmor /tmp/kd-caps/lsm.txt; then echo yes > /tmp/kd-caps/apparmor-active.txt; else echo no > /tmp/kd-caps/apparmor-active.txt; fi
cat /tmp/kd-caps/lsm.txt /tmp/kd-caps/apparmor-active.txt
```

On a stock Ubuntu VM you should see `apparmor` in the list and `aa-status` reporting loaded profiles. On kernels built without it, the honest answer is `no` — and that fact would change your entire hardening plan.

</details>
