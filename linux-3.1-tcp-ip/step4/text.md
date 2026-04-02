# Ports and Protocols

Network services listen on specific port numbers. The first 1024 ports (0-1023) are **well-known ports** reserved for standard services.

## Common Well-Known Ports

| Port | Service | Protocol |
|------|---------|----------|
| 22   | SSH     | TCP      |
| 53   | DNS     | TCP/UDP  |
| 80   | HTTP    | TCP      |
| 443  | HTTPS   | TCP      |
| 6443 | Kubernetes API | TCP |

## /etc/services

Linux maintains a mapping of port numbers to service names in `/etc/services`. This file is used by many tools to translate between port numbers and human-readable names.

```bash
cat /etc/services              # Full list
grep -w 80 /etc/services       # Find port 80
grep ssh /etc/services         # Find SSH entries
```

## Task

Find the service that runs on port 22 by looking it up in `/etc/services`. Save the service name to `~/port22-service.txt`.

<details>
<summary>Hint 1</summary>
Use <code>grep</code> to search for port 22 in <code>/etc/services</code>.
</details>

<details>
<summary>Hint 2</summary>
<code>grep -w "22/tcp" /etc/services | awk '{print $1}' > ~/port22-service.txt</code>
</details>
