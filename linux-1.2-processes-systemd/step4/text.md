## Step 4: cgroups v2 Basics

**Control Groups (cgroups)** are the kernel mechanism that limits, accounts for, and isolates resource usage. They are the foundation of container resource limits.

### cgroups v2

The unified cgroup hierarchy (v2) organizes controllers under `/sys/fs/cgroup/`:

```bash
ls /sys/fs/cgroup/
```

### Controllers

Each controller manages a type of resource:

| Controller | Resource |
|-----------|----------|
| `cpu` | CPU time |
| `memory` | Memory usage |
| `io` | Block I/O |
| `pids` | Number of processes |

### Viewing available controllers

```bash
cat /sys/fs/cgroup/cgroup.controllers
```

### How Kubernetes uses cgroups

When you set `resources.limits.cpu: "500m"` on a pod, Kubernetes tells the container runtime to create a cgroup with the appropriate CPU limit. The kernel enforces it.

### Your task

List the available cgroup controllers and save to `~/cgroup-controllers.txt`.

<details>
<summary>Hint</summary>

```bash
cat /sys/fs/cgroup/cgroup.controllers > ~/cgroup-controllers.txt
```

If that file doesn't exist (cgroups v1), try:

```bash
ls /sys/fs/cgroup/ > ~/cgroup-controllers.txt
```
</details>
