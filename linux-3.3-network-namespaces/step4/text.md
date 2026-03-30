# Namespace Isolation

Network namespaces provide true isolation. The `lab-ns` namespace can reach the host through the veth pair (`10.200.1.1`), but it **cannot** reach the host's main network interface IP — because there is no route from `lab-ns` to that network.

This is exactly how container networking works: a container can only reach networks that have been explicitly configured with routes and bridges.

## Understanding Isolation

From inside `lab-ns`, the only reachable network is `10.200.1.0/24` (the veth pair subnet). The host's primary IP (on `eth0` or `ens*`) is on a different subnet, and `lab-ns` has no route to it.

```bash
# See what routes exist inside the namespace
ip netns exec lab-ns ip route show

# Try to reach the host's main IP — it should fail
ip netns exec lab-ns ping -c1 -W2 <host-main-ip>
```

## Task

1. Find the host's main IP address (on `eth0` or similar — not `veth0` or `lo`)
2. From inside `lab-ns`, attempt to ping that IP
3. Save the result (showing the failure) to `/root/isolation-test.txt`

This demonstrates that without explicit routing, namespaces are isolated from the broader network.

<details>
<summary>Refer to: ip-route(8) man page</summary>
Use <code>ip addr show</code> to find the host's main IP. Use <code>ip netns exec lab-ns ping -c1 -W2 &lt;ip&gt;</code> to test isolation. The ping should fail or time out — redirect the output (including stderr) to capture the failure.
</details>
