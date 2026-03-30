## Step 3: Connectivity Testing

When something isn't working, you need to test connectivity at different layers.

### ICMP (Layer 3)

```bash
ping -c 3 google.com       # send 3 pings
```

### TCP ports (Layer 4)

```bash
nc -zv localhost 80         # check if port 80 is open
nc -zv localhost 22         # check if port 22 is open
```

The `-z` flag means scan (don't send data), `-v` means verbose.

### HTTP (Layer 7)

```bash
curl -I http://localhost    # HTTP headers only
curl http://localhost       # full response
wget -qO- http://localhost  # quiet, output to stdout
```

### Your task

Nginx should be running from setup. Check if port 80 on localhost is open and save the result to `/root/port-check.txt`.

The file should contain the word "open" or "succeeded".

<details>
<summary>Hint</summary>

Use `nc` to check the port:

```bash
nc -zv localhost 80 2>&1 | grep -oE "(open|succeeded)" > /root/port-check.txt
```

Or a simpler approach:

```bash
if nc -z localhost 80 2>/dev/null; then echo "open"; else echo "closed"; fi > /root/port-check.txt
```
</details>
