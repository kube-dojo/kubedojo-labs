## Step 2: Append Content to Files

In the real world, you often need to add lines to an existing config file without destroying what's already there. That's where the `>>` (append) operator comes in.

### Overwrite vs. Append

- `>` **overwrites** -- replaces the entire file contents
- `>>` **appends** -- adds to the end of the file

Watch the difference:

```bash
echo "first" > /tmp/test.txt
cat /tmp/test.txt
```

Now overwrite it:

```bash
echo "replaced" > /tmp/test.txt
cat /tmp/test.txt
```

The word "first" is gone. Now try appending:

```bash
echo "line two" >> /tmp/test.txt
cat /tmp/test.txt
```

Both "replaced" and "line two" are there.

### Appending multiple lines

You can also use a heredoc with `>>`:

```bash
cat << EOF >> /tmp/test.txt
line three
line four
EOF
cat /tmp/test.txt
```

### Your task

Your `app.env` file from Step 1 has 4 lines. Append these two new lines to it:

```
LOG_LEVEL=info
DEBUG=false
```

The file should end up with 6 lines total. Do **not** overwrite the existing content.

<details>
<summary>Hint</summary>

```bash
echo "LOG_LEVEL=info" >> /home/user/configs/app.env
echo "DEBUG=false" >> /home/user/configs/app.env
```

Or with a heredoc:

```bash
cat << EOF >> /home/user/configs/app.env
LOG_LEVEL=info
DEBUG=false
EOF
```
</details>
