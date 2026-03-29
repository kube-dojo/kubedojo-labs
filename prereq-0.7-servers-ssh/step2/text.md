## Step 2: Check Listening Ports

When a service runs on a server, it **listens** on a network port. Knowing which ports are in use is essential for debugging and security.

### The ss command

`ss` (socket statistics) shows network connections. Key flags:

| Flag | Meaning |
|------|---------|
| `-t` | TCP connections only |
| `-l` | Listening sockets only |
| `-n` | Show port numbers (not service names) |
| `-p` | Show the process using each port |

Combined:

```bash
ss -tlnp
```

This shows all TCP ports that are listening, with the process name.

### Start nginx and check

The setup script installed nginx. Let's start it and see what port it listens on:

```bash
service nginx start
```

Now check the listening ports:

```bash
ss -tlnp
```

You should see nginx listening on port 80.

### Your task

1. Make sure nginx is running (start it if it isn't)
2. Save the full output of `ss -tlnp` to `/home/user/ports.txt`

<details>
<summary>Hint</summary>

```bash
service nginx start
ss -tlnp > /home/user/ports.txt
```
</details>
