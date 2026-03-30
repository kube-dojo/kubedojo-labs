# Creating Firewall Rules

Firewall rules control which traffic is allowed or denied. Each rule specifies match criteria (protocol, port, source, destination) and a **target** (action).

## Targets

| Target | Action                                      |
|--------|---------------------------------------------|
| ACCEPT | Allow the packet through                    |
| DROP   | Silently discard the packet                 |
| REJECT | Discard and send an error back to sender    |
| LOG    | Log the packet and continue processing      |

## Rule Syntax

```bash
# Block incoming traffic to port 8080
iptables -A INPUT -p tcp --dport 8080 -j DROP

# Allow incoming SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Delete a rule (same syntax but -D instead of -A)
iptables -D INPUT -p tcp --dport 8080 -j DROP
```

Flags:
- `-A` — append to chain
- `-I` — insert at top of chain
- `-p tcp` — match TCP protocol
- `--dport 8080` — match destination port 8080
- `-j DROP` — jump to DROP target

Nginx is now running on port 80.

## Task

1. Block all incoming TCP traffic to port 8080 using a DROP rule
2. Verify that port 80 (nginx) still works: `curl -s http://localhost:80`

<details>
<summary>Refer to: iptables(8) man page</summary>
Use <code>iptables -A INPUT -p tcp --dport &lt;port&gt; -j DROP</code> to block a port. The <code>-A INPUT</code> appends to the INPUT chain.
</details>
