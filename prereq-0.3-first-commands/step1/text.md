## Step 1: Navigate the Filesystem

Every file on Linux lives in a tree structure starting from `/` (root). The `~` symbol represents your **home directory**.

### Find out where you are
```bash
pwd
```

### List what's here
```bash
ls
```

### Your task
1. Navigate into your home directory: `cd ~`
2. Go into the `documents` directory.
3. Read the `welcome.txt` file to find the **secret code**.
4. Save that code (and only the code) into a file named `~/code.txt`.

<details>
<summary>Hint</summary>

```bash
cd ~/documents
cat welcome.txt
# Copy the code (DOJO123) and save it:
echo "DOJO123" > ~/code.txt
```
</details>
