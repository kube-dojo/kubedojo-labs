# Create a PID Namespace

A PID namespace isolates process IDs and process visibility. The first process inside becomes PID 1 of that namespace, even though the host sees it under a different number.

Two flags trip almost everyone up:

- `unshare --pid` creates the namespace for **child** processes, so you need `--fork` to start your shell inside it.
- Tools like `ps` read `/proc`, so you need `--mount-proc` to remount `/proc` to match the new PID view. Without it, `ps` still shows host processes and the namespace looks "broken" even though it isn't.

## Task

From inside a fresh PID namespace, record two pieces of evidence:

1. The namespace identity of the inner shell into `/tmp/kd-ns/pid-inside.txt` — it must **differ** from your step 1 baseline.
2. The number of processes visible inside into `/tmp/kd-ns/pid-count.txt` — a freshly isolated view shows only a handful, not the hundreds a host shows.

Run one command that creates the namespace, writes both files, and exits.

<details>
<summary>Hint</summary>

```bash
sudo unshare --pid --fork --mount-proc bash -c 'readlink /proc/$$/ns/pid > /tmp/kd-ns/pid-inside.txt; ps -e --no-headers | wc -l > /tmp/kd-ns/pid-count.txt'
cat /tmp/kd-ns/pid-inside.txt /tmp/kd-ns/pid-count.txt
```

Note the single quotes: `$$` must be expanded by the *inner* bash (where it is PID 1), not by your host shell.

</details>
