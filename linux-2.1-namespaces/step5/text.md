# Prove Mount Namespace Isolation

A mount namespace isolates the set of mount points a process sees. The same path can mean different things in two namespaces — which is exactly why a sidecar container cannot read the app container's log file without a shared volume.

You will mount a `tmpfs` **inside** a private mount namespace, write a file through that mount, and then check the host's view after the namespace exits. Predict first: which survives on the host — the directory, the mount, or the file?

## Task

Run one `unshare --mount` command that, inside a private mount namespace:

1. Creates `/tmp/kd-ns/mnt-demo` and mounts a small `tmpfs` on it.
2. Writes any text into `/tmp/kd-ns/mnt-demo/data.txt`.
3. Saves the mount evidence (`findmnt --mountpoint /tmp/kd-ns/mnt-demo -o TARGET,FSTYPE`) into `/tmp/kd-ns/mnt-evidence.txt`.

After it exits, confirm on the host: the mount is gone from your mount table and `data.txt` does not exist — the file lived in the namespace's tmpfs. The evidence file survives because `/tmp/kd-ns` sits on the shared underlying filesystem, not on the private mount.

<details>
<summary>Hint</summary>

```bash
sudo unshare --mount --propagation private bash -c 'mkdir -p /tmp/kd-ns/mnt-demo && mount -t tmpfs -o size=1m tmpfs /tmp/kd-ns/mnt-demo && echo namespace-data > /tmp/kd-ns/mnt-demo/data.txt && findmnt --mountpoint /tmp/kd-ns/mnt-demo -o TARGET,FSTYPE > /tmp/kd-ns/mnt-evidence.txt'
findmnt --mountpoint /tmp/kd-ns/mnt-demo || echo "host sees no mount here"
ls /tmp/kd-ns/mnt-demo/
cat /tmp/kd-ns/mnt-evidence.txt
```

</details>
