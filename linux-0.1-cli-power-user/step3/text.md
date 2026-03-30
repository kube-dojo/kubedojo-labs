## Step 3: Text Processing

Linux has a rich toolkit for slicing, filtering, and transforming text. These tools are the backbone of log analysis, data extraction, and automation scripts.

### Key tools

| Tool | Purpose | Example |
|------|---------|---------|
| `grep` | Filter lines matching a pattern | `grep "error" app.log` |
| `cut` | Extract columns by delimiter | `cut -d: -f1 /etc/passwd` |
| `awk` | Column-based processing | `awk '{print $1}' file` |
| `sed` | Stream editor (find/replace) | `sed 's/old/new/g' file` |
| `sort` | Sort lines | `sort file.txt` |
| `uniq` | Remove adjacent duplicates | `sort file \| uniq` |

### Your setup

The file `/root/access.log` contains sample Apache access log entries. Each line starts with an IP address.

Take a look:

```bash
cat /root/access.log
```

### Your task

Extract all unique IP addresses from `/root/access.log`, sort them, and save to `/root/unique-ips.txt` (one IP per line).

<details>
<summary>Hint</summary>

Use `awk` to extract the first column (IP address), then `sort` and `uniq` to deduplicate:

```bash
awk '{print $1}' /root/access.log | sort | uniq > /root/unique-ips.txt
```

Alternatively, `sort -u` combines sort and unique in one step.
</details>
