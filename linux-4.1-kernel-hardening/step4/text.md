# Secure Boot Parameters

The kernel command line (`/proc/cmdline`) contains parameters passed to the kernel at boot time. Some of these parameters have security implications — they can enable or disable protections like ASLR, Spectre mitigations, and module signature verification.

## Reading Boot Parameters

```bash
cat /proc/cmdline
```

## Security-Relevant Parameters

| Parameter | Purpose |
|-----------|---------|
| `nokaslr` | Disables kernel address space layout randomization (BAD) |
| `mitigations=off` | Disables CPU vulnerability mitigations (BAD) |
| `module.sig_enforce` | Requires signed kernel modules (GOOD) |
| `lockdown=confidentiality` | Restricts kernel features that leak data (GOOD) |
| `init_on_alloc=1` | Zero-fills memory on allocation (GOOD) |
| `slab_nomerge` | Prevents slab cache merging (GOOD for exploit mitigation) |

## Task

1. Read the current kernel boot parameters from `/proc/cmdline`
2. Identify any security-relevant parameters present (or note their absence)
3. Save your analysis to `/root/boot-params.txt` — include:
   - The full contents of `/proc/cmdline`
   - Which security parameters are present or missing
   - At least one recommendation for improving boot security

<details>
<summary>Refer to: kernel-parameters.txt in kernel documentation</summary>
The full list of kernel parameters is documented in <code>/usr/share/doc/linux-doc/</code> or at <a href="https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html">kernel.org</a>.
</details>
