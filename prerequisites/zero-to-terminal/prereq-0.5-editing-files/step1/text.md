## Step 1: Create Multi-Line Files

So far you've used `echo "text" > file` to create single-line files. But config files, scripts, and manifests are multi-line. Let's learn three ways to create them.

### Method 1: echo with escape sequences

The `-e` flag tells `echo` to interpret escape sequences like `\n` (newline):

```bash
echo -e "line1\nline2\nline3"
```

You can redirect this to a file:

```bash
echo -e "host=localhost\nport=3306" > /tmp/demo.conf
cat /tmp/demo.conf
```

### Method 2: Heredoc (cat << EOF)

A **heredoc** lets you write multiple lines naturally. Everything between `<< EOF` and `EOF` becomes the file content:

```bash
cat << EOF > /tmp/demo2.conf
database=myapp
host=localhost
port=5432
EOF
```

```bash
cat /tmp/demo2.conf
```

This is the most common way to create multi-line files in shell scripts and Kubernetes manifests.

### Method 3: Multiple echo commands

You can also build a file line by line. The first line uses `>` (create/overwrite) and subsequent lines use `>>` (append):

```bash
echo "first" > /tmp/demo3.txt
echo "second" >> /tmp/demo3.txt
echo "third" >> /tmp/demo3.txt
cat /tmp/demo3.txt
```

### Your task

Create the file `/home/user/configs/app.env` with exactly these four lines:

```
APP_NAME=kubedojo
APP_PORT=8080
DB_HOST=localhost
DB_PORT=5432
```

Use whichever method you prefer -- `echo -e`, heredoc, or multiple echoes.

<details>
<summary>Hint: using a heredoc</summary>

```bash
cat << EOF > /home/user/configs/app.env
APP_NAME=kubedojo
APP_PORT=8080
DB_HOST=localhost
DB_PORT=5432
EOF
```
</details>

<details>
<summary>Hint: using echo -e</summary>

```bash
echo -e "APP_NAME=kubedojo\nAPP_PORT=8080\nDB_HOST=localhost\nDB_PORT=5432" > /home/user/configs/app.env
```
</details>
