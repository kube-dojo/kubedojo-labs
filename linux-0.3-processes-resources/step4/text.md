## Step 4: Process Limits

Every process has resource limits — maximum open files, stack size, CPU time, etc. These limits prevent a single process from consuming all system resources.

### View limits

```bash
ulimit -a              # show all limits for current shell
```

Key limits:
- **open files** (`-n`): max file descriptors a process can have open
- **max user processes** (`-u`): max processes per user
- **stack size** (`-s`): max stack memory

### Per-process limits

You can see the limits for any running process:

```bash
cat /proc/1/limits
```

### Why this matters

Kubernetes containers inherit limits from the host (unless overridden). A common production issue is "too many open files" when the `nofile` limit is too low.

### Your task

Check the current open files limit (`ulimit -n`) and save it to `~/nofile-limit.txt`.

<details>
<summary>Hint</summary>

```bash
ulimit -n > ~/nofile-limit.txt
```
</details>
