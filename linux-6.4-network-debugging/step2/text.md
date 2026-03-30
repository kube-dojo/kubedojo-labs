# DNS Debugging

DNS issues are extremely common. Learning to debug DNS is essential.

## dig — DNS Lookup

```bash
# Simple lookup
dig example.com

# Specific record types
dig example.com A        # IPv4 address
dig example.com AAAA     # IPv6 address
dig example.com MX       # Mail servers
dig example.com NS       # Name servers

# Trace the full resolution path
dig +trace example.com

# Short output
dig +short example.com
```

## nslookup — Interactive DNS

```bash
nslookup example.com
nslookup -type=MX example.com
```

## Your Task

1. Debug DNS resolution for `google.com` using `dig`
2. Save the full output to `/root/dns-debug.txt`

```bash
dig google.com > /root/dns-debug.txt 2>&1
```
