## Step 2: Finding Files

Linux has several tools for finding files. Each has its strengths.

### find — the Swiss Army knife

```bash
find /usr -name "*.so"              # by name pattern
find /var -size +1M                 # by size (larger than 1MB)
find / -mtime -1                    # modified in last 24 hours
find /etc -type f -name "*.conf"    # only regular files
```

### locate — fast index-based search

```bash
updatedb                            # rebuild the index
locate nginx.conf                   # instant search
```

### which / whereis / type

```bash
which bash                          # find executable in PATH
whereis bash                        # binary, source, and manual
type ls                             # is it a builtin, alias, or file?
```

### Your task

Find all files larger than 1MB in `/usr` and save the count to `~/large-files-count.txt`.

<details>
<summary>Hint</summary>

```bash
find /usr -type f -size +1M 2>/dev/null | wc -l > ~/large-files-count.txt
```
</details>
