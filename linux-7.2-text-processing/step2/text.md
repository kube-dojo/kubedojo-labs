# sed — Stream Editing

`sed` performs text transformations on a stream (file or pipe).

## Search and Replace

```bash
# Replace first occurrence on each line
sed 's/old/new/' file.txt

# Replace all occurrences on each line
sed 's/old/new/g' file.txt

# Case-insensitive
sed 's/old/new/gi' file.txt

# In-place editing
sed -i 's/old/new/g' file.txt
```

## Other Operations

```bash
# Delete lines matching a pattern
sed '/pattern/d' file.txt

# Print only matching lines
sed -n '/pattern/p' file.txt

# Insert text before a line
sed '/pattern/i\New line before' file.txt
```

## Your Task

Transform `/root/app.conf` so that all **keys are UPPERCASE** (left side of `=`), and save to `/root/sed-output.txt`.

For example: `database_host=localhost` becomes `DATABASE_HOST=localhost`.

**Hint:**
```bash
sed 's/^\([^=]*\)/\U\1/' /root/app.conf > /root/sed-output.txt
```
