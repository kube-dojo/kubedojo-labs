# Charge Memory to the cgroup

A limit only matters for processes whose memory is *charged* to the group. Membership is set by writing a PID into `cgroup.procs`; children inherit it. Once inside, every allocation the process makes — heap, shell variables, stacks, page cache — is charged to the group's `memory.current`. That is why "the heap fits" does not mean "the process fits": the kernel accounts for the whole footprint.

## Task

Run a shell inside `kd-lab` that:

1. Records its own membership (`/proc/self/cgroup`) into `/tmp/kd-cg/inner-path.txt` — it must show the `kd-lab` path.
2. Allocates at least **8 MiB** (safely under the 64 MiB ceiling) and, while still holding it, records the group's `memory.current` into `/tmp/kd-cg/memory-current.txt`.

<details>
<summary>Hint</summary>

```bash
sudo sh -c 'echo $$ > /sys/fs/cgroup/kd-lab/cgroup.procs
cat /proc/self/cgroup > /tmp/kd-cg/inner-path.txt
big=$(head -c 8388608 /dev/zero | tr "\0" "a")
cat /sys/fs/cgroup/kd-lab/memory.current > /tmp/kd-cg/memory-current.txt'
cat /tmp/kd-cg/inner-path.txt /tmp/kd-cg/memory-current.txt
```

The single quotes matter: `$$` must be the *inner* shell's PID. The 8 MiB shell variable keeps the memory charged while `memory.current` is read; when the shell exits, the charge is released.

</details>
