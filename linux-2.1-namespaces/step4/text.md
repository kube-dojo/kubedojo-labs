# Enter a Namespace with nsenter

Real incident workflow: a minimal container image has no `ip`, no `ss`, no `tcpdump`. You cannot inspect its network from inside — but you can enter **only its network namespace** from the host and run host binaries against the container's network stack. That is what `nsenter` does.

`ip netns` registered `lab-net` as a file under `/run/netns/lab-net`. `nsenter --net=<file>` runs a command inside that network namespace while keeping your mount, PID, and user context on the host.

## Task

Record proof that a command entered `lab-net`'s network stack:

1. Save your host shell's network-namespace identity to `/tmp/kd-ns/net-host.txt`.
2. Use `nsenter` with the `/run/netns/lab-net` handle to save the identity seen *inside* to `/tmp/kd-ns/net-inside.txt`.

The two identities must differ — same machine, two network worlds.

<details>
<summary>Hint</summary>

```bash
readlink /proc/self/ns/net > /tmp/kd-ns/net-host.txt
sudo nsenter --net=/run/netns/lab-net readlink /proc/self/ns/net > /tmp/kd-ns/net-inside.txt
diff /tmp/kd-ns/net-host.txt /tmp/kd-ns/net-inside.txt
```

`diff` prints both lines because the identities differ. Try `sudo nsenter --net=/run/netns/lab-net ip addr` too: that is the host `ip` binary reporting the namespace's lonely view.

</details>
