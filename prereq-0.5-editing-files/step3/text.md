## Step 3: Search and Replace with sed

Sometimes you need to fix mistakes across a file without opening an editor. `sed` (stream editor) can find and replace text directly from the command line.

### Basic syntax

```
sed 's/old/new/' file        # print with first match replaced per line
sed 's/old/new/g' file       # print with ALL matches replaced per line
sed -i 's/old/new/g' file    # edit the file IN PLACE (-i)
```

The `-i` flag is key -- without it, `sed` only prints the result but doesn't change the file.

### Example

```bash
echo "color is gray" > /tmp/demo.txt
sed -i 's/gray/grey/' /tmp/demo.txt
cat /tmp/demo.txt
```

### Preview before changing

It's good practice to preview the change first (without `-i`):

```bash
sed 's/grey/gray/' /tmp/demo.txt
```

This shows you what the result would look like. If it's correct, run it again with `-i`.

### Your task

The setup script created `/home/user/configs/nginx.conf` with two typos. Take a look:

```bash
cat /home/user/configs/nginx.conf
```

You'll see `listn` (should be `listen`) and `sever` (should be `server`).

Fix both typos using `sed -i`:

1. Replace `listn` with `listen`
2. Replace `sever` with `server` (this appears multiple times -- use the `g` flag)

<details>
<summary>Hint</summary>

```bash
sed -i 's/listn/listen/g' /home/user/configs/nginx.conf
sed -i 's/sever/server/g' /home/user/configs/nginx.conf
```

Verify your fix:

```bash
cat /home/user/configs/nginx.conf
```
</details>
