# Routing

## Viewing Routes

```bash
# Show routing table
ip route show

# Show route for a specific destination
ip route get 8.8.8.8
```

## Adding Static Routes

```bash
# Add a route via a gateway
ip route add 192.168.100.0/24 via <gateway-ip>

# Add a route via an interface
ip route add 10.20.30.0/24 dev eth0
```

## Your Task

1. Find your default gateway: `ip route | grep default`
2. Add a static route for `192.168.100.0/24` via your default gateway
3. Save the full routing table to `~/routes.txt`

**Hint:**
```bash
GW=$(ip route | grep default | awk '{print $3}')
ip route add 192.168.100.0/24 via $GW 2>/dev/null || true
ip route show > ~/routes.txt
```
