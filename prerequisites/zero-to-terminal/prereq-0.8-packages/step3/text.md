## Step 3: Inspect Installed Packages

Once software is installed, you often need to find where it lives, what version is running, and how many packages are on the system. Linux provides several tools for this.

### Find where a binary is installed

`which` tells you the full path of a command:

```bash
which bash
```

Output: `/usr/bin/bash`

`whereis` goes further -- it finds the binary, source, and man page:

```bash
whereis bash
```

### List installed packages

`dpkg -l` lists all installed packages:

```bash
dpkg -l | head -20
```

Lines starting with `ii` mean the package is **installed**. To count them:

```bash
dpkg -l | grep "^ii" | wc -l
```

### Get info about an installed package

```bash
dpkg -s curl
```

This shows the installed version, dependencies, and description.

### Your task

1. Find where the `curl` binary is installed using `which`, and save the path to `/home/user/curl-path.txt`
2. Count the total number of installed packages (lines starting with `ii` in `dpkg -l` output), and save the count to `/home/user/package-count.txt`

<details>
<summary>Hint</summary>

```bash
which curl > /home/user/curl-path.txt
dpkg -l | grep "^ii" | wc -l > /home/user/package-count.txt
```

Verify:

```bash
cat /home/user/curl-path.txt
cat /home/user/package-count.txt
```
</details>
