# Firewall Management

`iptables` is the traditional Linux firewall tool. It filters packets based on rules organized in chains.

## Key Concepts

| Chain | Purpose |
|-------|---------|
| `INPUT` | Packets destined for this host |
| `OUTPUT` | Packets originating from this host |
| `FORWARD` | Packets being routed through this host |

## Basic Commands

```bash
# List current rules
iptables -L -n -v

# Allow SSH (port 22)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP (port 80)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT

# Default deny everything else
iptables -P INPUT DROP
```

## Your Task

1. Create iptables rules that:
   - Allow loopback traffic
   - Allow established/related connections
   - Allow SSH (port 22)
   - Allow HTTP (port 80)
2. Save the rules to `~/firewall-rules.txt`

**Important:** Do NOT set the default policy to DROP in this lab, as it may lock you out.

```bash
iptables -L -n > ~/firewall-rules.txt
```
