## Step 2: Create Files and Directories

Now let's create things.

### Create a directory

```bash
mkdir /home/user/projects/my-first-project
```

Verify it exists:

```bash
ls /home/user/projects/
```

### Create a file with echo

```bash
echo "My name is a KubeDojo student" > /home/user/projects/my-first-project/about.txt
```

The `>` operator redirects output into a file (creates it if it doesn't exist, overwrites if it does).

### Create an empty file with touch

```bash
touch /home/user/projects/my-first-project/notes.txt
```

### Your task

1. Create a directory called `lab-results` inside `/home/user/projects/`
2. Create a file called `step2.txt` inside `lab-results` with the text "step 2 complete"

<details>
<summary>Hint</summary>

```bash
mkdir /home/user/projects/lab-results
echo "step 2 complete" > /home/user/projects/lab-results/step2.txt
```
</details>
