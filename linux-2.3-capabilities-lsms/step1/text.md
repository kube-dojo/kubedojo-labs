# Read and Decode Capability Sets

The kernel stores a process's capabilities as hex bitmasks in `/proc/<pid>/status`: `CapPrm` (permitted), `CapEff` (effective — what kernel checks see *now*), `CapInh` (inheritable), `CapBnd` (bounding — what can never be regained), and `CapAmb` (ambient). Raw hex is unreadable, so `capsh --decode` translates a mask into capability names. This is always the first stop when a process that "is root" still gets `operation not permitted`.

## Task

1. Record your shell's **effective** capability mask (the value of the `CapEff` line) into `/tmp/kd-caps/capeff.txt`.
2. Decode that exact mask with `capsh --decode` and record the output into `/tmp/kd-caps/decoded.txt`.

The verifier re-decodes your recorded mask itself, so the two files must genuinely correspond.

<details>
<summary>Hint</summary>

```bash
grep CapEff /proc/$$/status | awk '{print $2}' > /tmp/kd-caps/capeff.txt
capsh --decode=$(cat /tmp/kd-caps/capeff.txt) > /tmp/kd-caps/decoded.txt
cat /tmp/kd-caps/capeff.txt /tmp/kd-caps/decoded.txt
```

A root shell typically decodes to a long list including `cap_sys_admin`; an unprivileged shell decodes to an empty list (`0x0=`). Both are correct evidence — the point is reading the kernel's answer, not guessing.

</details>
