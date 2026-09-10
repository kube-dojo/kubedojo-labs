# Identify cgroup v2 and Your Own Group

Every cgroup diagnosis starts by naming the hierarchy, because the file paths differ completely between v1 and v2. On a v2 host, `/sys/fs/cgroup` is one unified tree (`cgroup2fs`), and each process belongs to exactly one path in it. The fastest check is the filesystem type; the second check is your own membership line in `/proc/self/cgroup`, which on v2 is a single line starting with `0::`.

## Task

Record two pieces of evidence:

1. The filesystem type of `/sys/fs/cgroup` into `/tmp/kd-cg/version.txt` — it must be `cgroup2fs`.
2. Your shell's cgroup membership (the full contents of `/proc/self/cgroup`) into `/tmp/kd-cg/self-path.txt`.

<details>
<summary>Hint</summary>

```bash
stat -fc %T /sys/fs/cgroup > /tmp/kd-cg/version.txt
cat /proc/self/cgroup > /tmp/kd-cg/self-path.txt
cat /tmp/kd-cg/version.txt /tmp/kd-cg/self-path.txt
```

On v2 the membership file has one `0::/some/path` line. On a systemd host you will typically see a `user.slice` or `system.slice` path — that is systemd using the same kernel mechanism containers use.

</details>
