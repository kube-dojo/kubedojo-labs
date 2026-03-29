## Step 3: Read and Search File Contents

### Read a file

```bash
cat /home/user/documents/welcome.txt
```

`cat` prints the entire file. For long files, use `head` (first lines) or `tail` (last lines):

```bash
head -3 /home/user/documents/fruits.txt
tail -2 /home/user/documents/fruits.txt
```

### Search inside files with grep

`grep` finds lines matching a pattern:

```bash
grep "running" /home/user/documents/services.txt
```

This shows only lines containing "running".

Try finding which fruit starts with "c":

```bash
grep "^c" /home/user/documents/fruits.txt
```

The `^` means "start of line".

### Your task

1. Use `grep` to find all **stopped** services in `/home/user/documents/services.txt`
2. Save the result to `/home/user/projects/lab-results/stopped.txt`

<details>
<summary>Hint</summary>

```bash
grep "stopped" /home/user/documents/services.txt > /home/user/projects/lab-results/stopped.txt
```
</details>
