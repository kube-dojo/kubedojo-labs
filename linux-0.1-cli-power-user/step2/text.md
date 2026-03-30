## Step 2: Pipes and Redirection

Pipes (`|`) connect the output of one command to the input of another. Redirection (`>`, `>>`) sends output to files. Together, they turn simple commands into powerful data pipelines.

### The basics

- `>` — write output to a file (overwrites)
- `>>` — append output to a file
- `2>&1` — redirect stderr to the same place as stdout
- `|` — pipe stdout of one command into stdin of another
- `tee` — write to a file AND pass through to the next command

### Examples

```bash
echo "hello" > /tmp/test.txt       # write to file
echo "world" >> /tmp/test.txt      # append to file
cat /tmp/test.txt | wc -l          # count lines
ls /nonexistent 2>&1 | grep "No"   # capture errors too
echo "logged" | tee /tmp/tee.txt   # write to file AND screen
```

### Your task

Find all `.conf` files in `/etc`, count how many there are, and save the count to `/root/conf-count.txt`.

The file should contain just the number (e.g., `42`).

<details>
<summary>Hint</summary>

Use `find` to locate `.conf` files, pipe to `wc -l` to count, and redirect to the output file:

```bash
find /etc -name "*.conf" 2>/dev/null | wc -l > /root/conf-count.txt
```

The `2>/dev/null` suppresses permission errors you might hit on some directories.
</details>
