## Step 4: Absolute and Relative Paths

There are two ways to specify a file location: **absolute** paths (starting from `/`) and **relative** paths (starting from your current directory).

### Absolute paths

An absolute path always starts with `/` and works no matter where you are:

```bash
ls /home/user/lab-workspace/docs/drafts/
```

This works from any directory because it specifies the full path from root.

### Relative paths

A relative path starts from your current directory. First, navigate to the workspace:

```bash
cd /home/user/lab-workspace
```

Now use a relative path to get to `docs/drafts/`:

```bash
cd docs/drafts
pwd
```

You should see `/home/user/lab-workspace/docs/drafts`.

### Create a file using a relative path

While inside `docs/drafts/`, create a file:

```bash
touch relative_test.txt
```

Verify:

```bash
ls relative_test.txt
```

### Create a file using an absolute path

Now create a file using an absolute path -- this works regardless of your current directory:

```bash
touch /tmp/absolute_test.txt
```

Verify:

```bash
ls /tmp/absolute_test.txt
```

### Key difference

| Type | Example | Starts with |
|------|---------|-------------|
| Absolute | `/home/user/lab-workspace/docs` | `/` |
| Relative | `docs/drafts` | directory name |
| Parent | `../archive` | `..` |
| Current | `./report.txt` | `.` |

### Your task

Make sure you have:
1. Navigated to `docs/drafts/` using a relative path from the workspace
2. Created `relative_test.txt` inside `docs/drafts/`
3. Created `/tmp/absolute_test.txt` using an absolute path

<details>
<summary>Hint</summary>

```bash
cd /home/user/lab-workspace
cd docs/drafts
touch relative_test.txt
touch /tmp/absolute_test.txt
```
</details>
