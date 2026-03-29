## Step 2: Install a Package

Installing packages with `apt` is straightforward. Let's install `htop`, an interactive process viewer that's much more useful than the basic `top` command.

### Install syntax

```bash
apt install -y <package-name>
```

The `-y` flag automatically answers "yes" to confirmation prompts. Without it, apt asks you to confirm before installing.

### Install htop

```bash
apt install -y htop
```

Apt will download the package, resolve any dependencies, and install everything.

### Verify the installation

Check that the command is available:

```bash
htop --version
```

You should see something like `htop 3.x.x`.

### Your task

1. Install `htop` using `apt install`
2. Run `htop --version` and save the output to `/home/user/htop-version.txt`

<details>
<summary>Hint</summary>

```bash
apt install -y htop
htop --version > /home/user/htop-version.txt
```
</details>
