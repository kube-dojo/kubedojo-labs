# Cross the Limit: OOM Kill Evidence

When charged memory reaches `memory.max`, the kernel does not negotiate: it OOM-kills a process in the group with `SIGKILL`. The process cannot catch it, log a final line, or shut down gracefully — which is exactly why an OOMKilled pod so often has an empty application log. The proof lives in two places: the killed process exits with code **137** (128 + signal 9), and the group's `memory.events` increments its `oom_kill` counter.

## Task

1. Run a memory hog inside `kd-lab` and let the kernel kill it (`tail /dev/zero` grows without bound).
2. Record the hog's exit code into `/tmp/kd-cg/oom-exit.txt` — it must be `137`.
3. Record the `oom_kill` line of `/sys/fs/cgroup/kd-lab/memory.events` into `/tmp/kd-cg/oom-events.txt`.

The verifier also reads the **live** `memory.events`, so a real OOM kill must have happened in this group.

<details>
<summary>Hint</summary>

```bash
sudo sh -c 'echo $$ > /sys/fs/cgroup/kd-lab/cgroup.procs; exec tail /dev/zero'
echo $? > /tmp/kd-cg/oom-exit.txt
grep '^oom_kill ' /sys/fs/cgroup/kd-lab/memory.events > /tmp/kd-cg/oom-events.txt
cat /tmp/kd-cg/oom-exit.txt /tmp/kd-cg/oom-events.txt
```

`tail /dev/zero` buffers an endless stream in memory, hits the 64 MiB ceiling within a second, and dies. The `exec` keeps a single process in the group so the exit code you capture is the killed process's own.

</details>
