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

### Move around

Go to the user's home directory and see what's there:

```bash
cd /home/user
ls -la
```

### Your task

Navigate into the `documents` directory, read the `welcome.txt` file, find the **secret code**, and save it to a file named `/root/code.txt`.

<details>
<summary>Hint</summary>

```bash
cd /home/user/documents
cat welcome.txt
echo "DOJO123" > /root/code.txt
```
</details>
