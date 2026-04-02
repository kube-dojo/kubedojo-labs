# iptables Basics

`iptables` organizes rules into **tables** and **chains**. Packets traverse chains in order; the first matching rule determines the packet's fate.

## Tables

| Table  | Purpose                          | Key Chains              |
|--------|----------------------------------|-------------------------|
| filter | Accept/drop/reject packets       | INPUT, FORWARD, OUTPUT  |
| nat    | Network address translation      | PREROUTING, POSTROUTING, OUTPUT |
| mangle | Packet header modification       | All chains              |

## Chains (filter table)

- **INPUT** — packets destined for the local system
- **OUTPUT** — packets originating from the local system
- **FORWARD** — packets being routed through the system

## Key Commands

```bash
iptables -L                  # List filter table rules
iptables -L -v -n            # Verbose, numeric output
iptables -t nat -L           # List NAT table rules
iptables -t mangle -L        # List mangle table rules
```

## Task

List all iptables rules (all chains in the filter table) and save the output to `~/iptables-rules.txt`.

<details>
<summary>Refer to: iptables(8) man page</summary>
See <code>man iptables</code> for the <code>-L</code> (list) option. Use <code>-v -n</code> for verbose numeric output.
</details>
