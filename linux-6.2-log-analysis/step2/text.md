# Find HTTP Errors

HTTP 5xx status codes indicate server-side errors:

| Code | Meaning |
|------|---------|
| 500 | Internal Server Error |
| 502 | Bad Gateway |
| 503 | Service Unavailable |
| 504 | Gateway Timeout |

## Extracting Status Codes

The HTTP status code is typically the 9th field in Apache Combined Log Format:

```bash
# List all status codes
awk '{print $9}' /root/access.log | sort | uniq -c | sort -rn

# Filter 5xx errors only
awk '$9 ~ /^5/' /root/access.log
```

## Your Task

1. Count all 5xx errors in `/root/access.log`
2. Save the count to `/root/5xx-count.txt`

**Hint:**
```bash
awk '$9 ~ /^5/' /root/access.log | wc -l > /root/5xx-count.txt
```
