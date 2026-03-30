## Step 1: Network Interfaces

The `ip` command is the modern replacement for `ifconfig`. It shows and configures interfaces, addresses, and routes.

### View interfaces and addresses

```bash
ip addr show           # or just: ip a
```

Each interface has:
- **lo** — loopback (127.0.0.1)
- **eth0** (or ens*) — the primary network interface

### View routes

```bash
ip route show          # or just: ip r
```

The **default** route tells the system where to send traffic that doesn't match a more specific rule.

### View link status

```bash
ip link show
```

### Your task

Find your primary (non-loopback) IP address and save it to `/root/my-ip.txt`.

The file should contain just the IP address (e.g., `172.17.0.2`).

<details>
<summary>Hint</summary>

Extract the IP from `ip addr`:

```bash
ip -4 addr show scope global | grep inet | awk '{print $2}' | cut -d/ -f1 | head -1 > /root/my-ip.txt
```

Or use `hostname -I`:

```bash
hostname -I | awk '{print $1}' > /root/my-ip.txt
```
</details>
