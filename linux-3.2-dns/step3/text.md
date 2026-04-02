# DNS Configuration

Linux systems resolve DNS using the nameservers listed in `/etc/resolv.conf`. On modern systems, this file may be managed by `systemd-resolved` or NetworkManager.

## /etc/resolv.conf

```
nameserver 8.8.8.8        # Primary DNS server
nameserver 8.8.4.4        # Secondary DNS server
search example.com         # Search domain for short names
options timeout:2 attempts:3
```

Key directives:
- **nameserver** — IP address of a DNS server (max 3)
- **search** — domain list appended to unqualified names
- **options** — timeout, attempts, and other resolver settings

## systemd-resolved

Many modern Ubuntu systems use `systemd-resolved`, which provides a local caching DNS stub at `127.0.0.53`. The actual upstream servers are configured via:

```bash
resolvectl status          # Show resolved configuration
systemd-resolve --status   # Older syntax
```

## Task

Extract the current nameserver IP(s) from your system and save them to `~/nameservers.txt` (one IP per line).

<details>
<summary>Hint 1</summary>
Look at <code>/etc/resolv.conf</code> for lines starting with <code>nameserver</code>.
</details>

<details>
<summary>Hint 2</summary>
<code>grep "^nameserver" /etc/resolv.conf | awk '{print $2}' > ~/nameservers.txt</code>
</details>
