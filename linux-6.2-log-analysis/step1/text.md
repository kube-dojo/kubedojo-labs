# Parse Apache Logs

Apache Combined Log Format looks like:

```
IP - - [timestamp] "METHOD /path HTTP/1.1" STATUS SIZE
```

## Extracting Fields with awk

```bash
# Extract just IPs
awk '{print $1}' ~/access.log

# Count requests per IP
awk '{print $1}' ~/access.log | sort | uniq -c | sort -rn
```

## Your Task

Parse `~/access.log` and find the **top 5 IPs by request count**. Save to `~/top-ips.txt`.

Each line should show the count and IP:

```
   6 10.0.0.5
   5 192.168.1.10
   ...
```

**Hint:**
```bash
awk '{print $1}' ~/access.log | sort | uniq -c | sort -rn | head -5 > ~/top-ips.txt
```
