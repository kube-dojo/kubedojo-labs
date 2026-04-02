## Step 3: sudo Configuration

`sudo` lets users run commands as root (or other users) without sharing the root password. It follows the **principle of least privilege**.

### The sudoers file

The main config is `/etc/sudoers`. Always edit it with `visudo` (syntax-checks before saving).

### sudoers syntax

```
# user  hosts=(run_as)  commands
alice   ALL=(ALL)       ALL              # full sudo
bob     ALL=(ALL)       /usr/bin/apt     # only apt
%devs   ALL=(ALL)       NOPASSWD: ALL    # group, no password
```

### Adding a rule safely

Rather than editing `/etc/sudoers` directly, add a file in `/etc/sudoers.d/`:

```bash
echo 'developer ALL=(ALL) /usr/bin/apt' > /etc/sudoers.d/developer
chmod 440 /etc/sudoers.d/developer
```

### Your task

1. Give the `developer` user sudo access for the `apt` command only
2. Save the sudoers rule line to `~/sudo-rule.txt`

<details>
<summary>Hint</summary>

Create a sudoers drop-in file:

```bash
echo 'developer ALL=(ALL) /usr/bin/apt' > /etc/sudoers.d/developer
chmod 440 /etc/sudoers.d/developer
echo 'developer ALL=(ALL) /usr/bin/apt' > ~/sudo-rule.txt
```
</details>
