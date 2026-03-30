# Connectivity Checks

Start network debugging with basic connectivity tests.

## ping — ICMP Reachability

```bash
# Basic ping (4 packets)
ping -c 4 8.8.8.8

# Ping with timeout
ping -c 4 -W 2 8.8.8.8
```

## traceroute — Path Discovery

```bash
# Trace the route to a destination
traceroute -m 10 8.8.8.8
```

Shows each hop between you and the destination. Useful for finding where packets are being dropped.

## Your Task

1. Test connectivity to `8.8.8.8` (Google DNS) using ping
2. Save the ping results to `/root/connectivity.txt`

```bash
ping -c 4 8.8.8.8 > /root/connectivity.txt 2>&1
```

If ping is blocked in the environment, use an alternative:
```bash
(ping -c 4 8.8.8.8 || echo "Ping blocked - using alternative") > /root/connectivity.txt 2>&1
ip route get 8.8.8.8 >> /root/connectivity.txt 2>&1
```
