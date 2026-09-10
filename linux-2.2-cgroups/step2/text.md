# Create a cgroup with a Memory Limit

Creating a cgroup is just `mkdir` inside `/sys/fs/cgroup`; the kernel populates the controller files. Writing a byte value into `memory.max` turns the directory into a hard memory boundary — the exact mechanism a Kubernetes memory limit becomes on the node. A fresh group shows `max` (no ceiling) until you write one.

## Task

1. Create the cgroup `/sys/fs/cgroup/kd-lab`.
2. Set its hard memory limit to exactly **64 MiB** (`67108864` bytes) by writing to `memory.max`.
3. Record the limit the kernel now reports into `/tmp/kd-cg/memory-max.txt`.

The verifier reads the **live** `memory.max`, so the limit must really be set — a fabricated evidence file is not enough.

<details>
<summary>Hint</summary>

```bash
sudo mkdir -p /sys/fs/cgroup/kd-lab
echo 67108864 | sudo tee /sys/fs/cgroup/kd-lab/memory.max
cat /sys/fs/cgroup/kd-lab/memory.max > /tmp/kd-cg/memory-max.txt
cat /tmp/kd-cg/memory-max.txt
```

If the write fails with "No such file or directory" for `memory.max`, the memory controller is not delegated to children of the root — the lab setup enables it, so re-run the setup script first.

</details>
