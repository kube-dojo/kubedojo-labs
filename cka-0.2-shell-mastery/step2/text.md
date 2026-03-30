# Output Filtering

Kubernetes commands produce a lot of output. Filtering it quickly is essential.

**Key tools:**
- `grep` — filter lines matching a pattern
- `awk '{print $1}'` — extract specific columns
- `jq '.field'` — parse JSON output
- `column -t` — align output in columns

A sample JSON file has been created at `/root/sample.json` containing a list of people with names, roles, and ages.

## Task

Extract all names from the `items` array in `/root/sample.json` and save them (one per line) to `/root/names.txt`.

## Hint

Use `jq` to parse the JSON. The expression `jq -r '.items[].name'` extracts names from the array. The `-r` flag outputs raw strings without quotes.
