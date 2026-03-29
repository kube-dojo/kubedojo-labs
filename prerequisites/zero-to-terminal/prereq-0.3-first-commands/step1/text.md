## Step 1: Navigate the Filesystem

Every file on Linux lives in a tree structure starting from `/` (root). Let's explore.

### Find out where you are

```bash
pwd
```

This prints your **present working directory**.

### List what's here

```bash
ls
```

Now try with details:

```bash
ls -la
```

The `-l` flag shows permissions, owner, size, and date. The `-a` flag shows hidden files (starting with `.`).

### Move around

Go to the user's home directory and see what's there:

```bash
cd /home/user
ls -la
```

You should see three directories: `documents`, `projects`, and `downloads`.

### Your task

Navigate into the `documents` directory and list its contents.

<details>
<summary>Hint</summary>

```bash
cd /home/user/documents
ls
```
</details>
