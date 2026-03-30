# Veth Pairs

A **veth pair** (virtual ethernet pair) is like a network cable with two ends. When you send a packet into one end, it comes out the other. This is how you connect two network namespaces — or a namespace to the host.

## How Veth Pairs Work

```
┌─────────────────┐        ┌─────────────────┐
│   Host (root)   │        │   lab-ns         │
│                 │        │                  │
│   veth0 ◄──────────────────► veth1          │
│                 │        │                  │
└─────────────────┘        └─────────────────┘
```

Both ends of the pair are created in the host namespace. You then move one end into the target namespace.

## Key Commands

```bash
# Create a veth pair
ip link add veth0 type veth peer name veth1

# Move one end into a namespace
ip link set veth1 netns lab-ns

# Verify from inside the namespace
ip netns exec lab-ns ip link show
```

## Task

Create a veth pair with endpoints named `veth0` and `veth1`. Move `veth1` into the `lab-ns` namespace.

<details>
<summary>Refer to: ip-link(8) man page</summary>
See <code>man ip-link</code> for veth pair creation syntax. The <code>type veth peer name</code> option creates both ends simultaneously.
</details>
