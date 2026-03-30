# Configuring Namespace Networking

The veth pair is now in place, but both ends are DOWN and have no IP addresses. You need to:

1. Assign IP addresses to both ends
2. Bring both interfaces UP
3. Bring up the loopback interface inside the namespace

## Network Topology

```
Host (root namespace)          lab-ns namespace
┌──────────────────┐          ┌──────────────────┐
│ veth0            │          │ veth1             │
│ 10.200.1.1/24    │◄────────►│ 10.200.1.2/24    │
│ state: UP        │          │ state: UP         │
└──────────────────┘          └──────────────────┘
```

## Key Commands

```bash
# Assign IP on host side
ip addr add <ip>/<mask> dev veth0
ip link set veth0 up

# Assign IP inside namespace
ip netns exec lab-ns ip addr add <ip>/<mask> dev veth1
ip netns exec lab-ns ip link set veth1 up
ip netns exec lab-ns ip link set lo up
```

## Task

1. Assign `10.200.1.1/24` to `veth0` on the host and bring it UP
2. Inside `lab-ns`, assign `10.200.1.2/24` to `veth1` and bring it UP
3. Bring up the loopback interface inside `lab-ns`

The goal: ping `10.200.1.1` (host) from inside `lab-ns`.

<details>
<summary>Refer to: ip-address(8) and ip-link(8) man pages</summary>
Use <code>ip addr add</code> for addressing and <code>ip link set ... up</code> to activate interfaces. Remember to prefix namespace commands with <code>ip netns exec lab-ns</code>.
</details>
