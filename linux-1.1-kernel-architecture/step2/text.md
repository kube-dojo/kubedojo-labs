## Step 2: The /proc Filesystem

`/proc` is a virtual filesystem — no actual files on disk. The kernel populates it with real-time system information.

### System info

```bash
cat /proc/cpuinfo          # CPU details
cat /proc/meminfo          # memory details
cat /proc/version          # kernel version (verbose)
cat /proc/uptime           # seconds since boot
```

### Per-process info

Every running process has a directory under `/proc/PID/`:

```bash
ls /proc/1/                # PID 1's info
cat /proc/1/cmdline        # command that started it
cat /proc/1/status         # process status
cat /proc/1/limits         # resource limits
```

### Your task

Extract the CPU model name from `/proc/cpuinfo` and save it to `~/cpu-model.txt`.

<details>
<summary>Hint</summary>

```bash
grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //' > ~/cpu-model.txt
```

Or using awk:

```bash
awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo | sed 's/^ //' > ~/cpu-model.txt
```
</details>
