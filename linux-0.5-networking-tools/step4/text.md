## Step 4: Network Monitoring

When debugging network issues, you need to see what connections exist and what's listening.

### ss (Socket Statistics)

`ss` is the modern replacement for `netstat`:

```bash
ss -tlnp                   # TCP listening, numeric, with process
ss -ulnp                   # UDP listening
ss -s                      # summary statistics
```

Flags:
- `-t` — TCP
- `-u` — UDP
- `-l` — listening sockets only
- `-n` — don't resolve names (faster)
- `-p` — show process using the socket

### netstat (legacy)

```bash
netstat -tlnp              # same as ss -tlnp
```

### tcpdump (packet capture)

```bash
tcpdump -i eth0 -c 5       # capture 5 packets on eth0
tcpdump -i any port 80     # capture HTTP traffic
```

### Your task

List all listening TCP ports and save the output to `~/listening-ports.txt`.

<details>
<summary>Hint</summary>

```bash
ss -tlnp > ~/listening-ports.txt
```

Or with netstat:

```bash
netstat -tlnp > ~/listening-ports.txt
```
</details>
