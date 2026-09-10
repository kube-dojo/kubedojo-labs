# Throttle CPU with a Quota

CPU limits fail differently from memory limits: nothing dies. `cpu.max` holds a quota and a period ("20000 100000" = 20 ms of CPU per 100 ms = 20%). A group that burns its quota early is paused until the next period — the service is slow while the node looks idle. The proof lives in `cpu.stat`: `nr_throttled` counts throttled periods and `throttled_usec` totals the stolen time.

## Task

1. Set the `kd-lab` quota to exactly **20%**: write `20000 100000` to its `cpu.max`.
2. Run a busy loop inside `kd-lab` for about 3 seconds so it collides with the quota.
3. Record the live `cpu.max` into `/tmp/kd-cg/cpu-max.txt` and the `nr_throttled`/`throttled_usec` lines of `cpu.stat` into `/tmp/kd-cg/cpu-throttle.txt`.

<details>
<summary>Hint</summary>

```bash
echo "20000 100000" | sudo tee /sys/fs/cgroup/kd-lab/cpu.max
sudo sh -c 'echo $$ > /sys/fs/cgroup/kd-lab/cgroup.procs; timeout 3 sh -c "while :; do :; done"' || true
cat /sys/fs/cgroup/kd-lab/cpu.max > /tmp/kd-cg/cpu-max.txt
grep -E '^(nr_throttled|throttled_usec) ' /sys/fs/cgroup/kd-lab/cpu.stat > /tmp/kd-cg/cpu-throttle.txt
cat /tmp/kd-cg/cpu-max.txt /tmp/kd-cg/cpu-throttle.txt
```

A 100%-hungry loop under a 20% quota gets throttled in nearly every period — expect `nr_throttled` in the dozens after 3 seconds.

</details>
