# Enforce a Seccomp Syscall Filter

Seccomp filters system calls *before* the kernel executes them — a different axis from paths (AppArmor) or named privileges (capabilities). Container runtimes apply a default seccomp profile to every container; systemd exposes the same kernel feature for ordinary services through `SystemCallFilter=`. A process that hits a denied syscall is killed with `SIGSYS`: the operation does not fail politely, it never happens.

## Task

1. Record your shell's current seccomp mode (the `Seccomp:` line of `/proc/self/status`) into `/tmp/kd-caps/seccomp-mode.txt`.
2. Run `mkdir /tmp/kd-caps/blocked-dir` in a transient systemd unit with `SystemCallFilter='~mkdir mkdirat'` (deny-list both syscall spellings — modern glibc uses `mkdirat`). Record the exit status as `exit=<n>` into `/tmp/kd-caps/seccomp-blocked.txt`.
3. Run an unfiltered control: `mkdir -p /tmp/kd-caps/allowed-dir` in a transient unit without a filter.

Enforcement proof: `allowed-dir` exists, `blocked-dir` does **not**, and the filtered run exited nonzero.

<details>
<summary>Hint</summary>

```bash
grep Seccomp: /proc/$$/status > /tmp/kd-caps/seccomp-mode.txt
sudo systemd-run --wait --quiet -p SystemCallFilter='~mkdir mkdirat' bash -c 'mkdir /tmp/kd-caps/blocked-dir'; echo "exit=$?" > /tmp/kd-caps/seccomp-blocked.txt
sudo systemd-run --wait --quiet bash -c 'mkdir -p /tmp/kd-caps/allowed-dir'
cat /tmp/kd-caps/seccomp-mode.txt /tmp/kd-caps/seccomp-blocked.txt
```

`Seccomp: 0` means your shell runs unfiltered; the transient unit runs in mode 2 (filter). The blocked `mkdir` dies on `SIGSYS`, so no directory appears — the same mechanism that makes `mount` or `kexec_load` vanish from a container's reachable kernel surface.

</details>
