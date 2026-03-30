## Step 4: File Ownership in Practice

In real projects, you often need shared directories where multiple team members can collaborate. This requires careful ownership and permission setup.

### The SGID pattern for shared directories

When SGID (Set Group ID) is set on a directory, new files created inside inherit the directory's group (not the creating user's primary group). This is essential for shared project directories.

```bash
chmod g+s /opt/project    # set SGID on directory
```

### Ownership commands

```bash
chown user:group file     # change owner and group
chown -R user:group dir   # recursive
chgrp group file          # change group only
```

### Your task

Create a shared project directory with the following properties:

1. Path: `/opt/project`
2. Owner: `developer`
3. Group: `devteam`
4. Group-writable (770)
5. SGID bit set (so new files inherit the `devteam` group)

<details>
<summary>Hint</summary>

```bash
mkdir -p /opt/project
chown developer:devteam /opt/project
chmod 2770 /opt/project
```

The `2` prefix sets the SGID bit. `770` gives owner and group full access.
</details>
