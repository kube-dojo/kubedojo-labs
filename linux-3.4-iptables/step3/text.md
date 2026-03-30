# NAT and Port Forwarding

Network Address Translation (NAT) modifies packet addresses as they pass through the system. This is how routers share a single public IP, and how Kubernetes Services redirect traffic to pods.

## NAT Types

| Type       | Chain       | Purpose                                  |
|------------|-------------|------------------------------------------|
| DNAT       | PREROUTING  | Change destination address (port forward) |
| SNAT       | POSTROUTING | Change source address (masquerade)       |
| MASQUERADE | POSTROUTING | SNAT using the outgoing interface's IP   |

## DNAT (Destination NAT) — Port Forwarding

Forward traffic arriving on port 8080 to a different destination:

```bash
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 127.0.0.1:80
```

For local traffic (originating on the same host), use the OUTPUT chain:

```bash
iptables -t nat -A OUTPUT -p tcp --dport 8080 -j DNAT --to-destination 127.0.0.1:80
```

## Task

Create a DNAT rule that forwards TCP traffic on port 8080 to `127.0.0.1:80` (where nginx is running). Add the rule to both the PREROUTING and OUTPUT chains of the nat table so it works for both external and local traffic.

<details>
<summary>Refer to: iptables-extensions(8) man page</summary>
See the DNAT target section. Use <code>-t nat</code> to specify the nat table. For local testing, the OUTPUT chain rule is needed since PREROUTING only handles external traffic.
</details>
