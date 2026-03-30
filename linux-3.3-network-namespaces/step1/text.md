# Creating Network Namespaces

A network namespace is an isolated copy of the network stack. Each namespace gets its own interfaces, routing tables, firewall rules, and `/proc/net` entries.

## Key Commands

```bash
ip netns add <name>         # Create a namespace
ip netns list               # List all namespaces
ip netns delete <name>      # Delete a namespace
ip netns exec <name> <cmd>  # Run a command inside a namespace
```

## What Happens Inside a New Namespace

A freshly created namespace has only a loopback interface (`lo`), and it is DOWN by default:

```bash
ip netns exec my-ns ip link show
# 1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN
```

No external interfaces, no routes, no connectivity — complete isolation.

## Task

Create a network namespace called `lab-ns`.

<details>
<summary>Refer to: ip-netns(8) man page</summary>
See <code>man ip-netns</code> for the full <code>ip netns add</code> documentation.
</details>
