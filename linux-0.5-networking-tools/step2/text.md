## Step 2: DNS Tools

DNS translates domain names to IP addresses. Kubernetes uses DNS heavily — every Service gets a DNS name.

### Key tools

```bash
dig google.com              # detailed DNS query
dig google.com +short       # just the IP
nslookup google.com         # simpler DNS query
host google.com             # simplest form
```

### DNS configuration

```bash
cat /etc/resolv.conf        # see configured nameservers
```

### Record types

```bash
dig google.com A            # IPv4 address
dig google.com AAAA         # IPv6 address
dig google.com MX           # mail servers
dig google.com NS           # name servers
```

### Your task

Resolve `google.com` to an IP address and save it to `/root/google-ip.txt`.

The file should contain just one IP address.

<details>
<summary>Hint</summary>

Use `dig` with `+short`:

```bash
dig google.com +short | head -1 > /root/google-ip.txt
```

Or use `host`:

```bash
host google.com | grep "has address" | head -1 | awk '{print $4}' > /root/google-ip.txt
```
</details>
