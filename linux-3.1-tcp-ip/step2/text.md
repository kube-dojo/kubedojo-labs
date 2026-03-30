# Routing Tables

The Linux kernel maintains a routing table that determines where to send outgoing packets. The **default gateway** is the router that handles traffic destined for networks not directly connected to the host.

## Key Commands

```bash
ip route show         # Show the full routing table
ip route get 8.8.8.8  # Show which route is used to reach a specific IP
```

## Reading the Routing Table

A typical output looks like:

```
default via 172.17.0.1 dev eth0
172.17.0.0/16 dev eth0 proto kernel scope link src 172.17.0.2
```

- **default via 172.17.0.1** — the default gateway is 172.17.0.1
- **172.17.0.0/16 dev eth0** — the local subnet is directly reachable on eth0

## Task

Find the default gateway IP and save it to `/root/gateway.txt`. The file should contain only the gateway IP address (one line).

<details>
<summary>Hint 1</summary>
Use <code>ip route</code> and look for the line starting with <code>default via</code>.
</details>

<details>
<summary>Hint 2</summary>
Extract the IP with: <code>ip route | grep default | awk '{print $3}'</code>
</details>
