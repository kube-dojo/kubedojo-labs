# Read Namespace Membership

The kernel exposes each process's namespace membership as symbolic links under `/proc/<pid>/ns`. Two processes share a namespace of a given type exactly when the corresponding links point to the same object. That comparison is objective evidence — more reliable than guessing from container names.

Look at your own shell first. The shell variable `$$` expands to the current shell's PID:

```bash
ls -l /proc/$$/ns
```

Now compare your shell against PID 1 (the init process). On this lab VM they should share namespaces; inside a container they would not:

```bash
sudo ls -l /proc/1/ns
readlink /proc/$$/ns/pid
sudo readlink /proc/1/ns/pid
```

`lsns` summarizes namespace objects system-wide; try `lsns -t net` and `lsns -t pid`.

## Task

Save your shell's **PID namespace identity** to `/tmp/kd-ns/ns-baseline.txt`. It must be recorded from your normal shell (not from inside any namespace you create later) — it is the baseline the next step is compared against.

<details>
<summary>Hint</summary>

```bash
readlink /proc/$$/ns/pid > /tmp/kd-ns/ns-baseline.txt
cat /tmp/kd-ns/ns-baseline.txt
```

</details>
