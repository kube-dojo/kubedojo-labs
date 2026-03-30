# Combining Tools

The real power comes from combining tools with pipes.

## Key Pipeline Tools

| Tool | Purpose |
|------|---------|
| `sort` | Sort lines |
| `uniq` | Remove duplicates (requires sorted input) |
| `uniq -c` | Count occurrences |
| `wc -l` | Count lines |
| `xargs` | Pass stdin as arguments |
| `tr` | Translate/delete characters |
| `cut` | Cut specific columns |

## Example Pipeline

```bash
# Find top 10 most common words in a file
cat file.txt | tr -s ' ' '\n' | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -rn | head -10
```

## Your Task

Process `/root/sample.log` to find the **top 10 most frequent words** (case-insensitive, excluding timestamps). Save to `/root/word-freq.txt`.

Each line should have the count and word:
```
  8 the
  3 is
  ...
```

**Hint:**
```bash
awk '{for(i=3;i<=NF;i++) print tolower($i)}' /root/sample.log | sort | uniq -c | sort -rn | head -10 > /root/word-freq.txt
```
