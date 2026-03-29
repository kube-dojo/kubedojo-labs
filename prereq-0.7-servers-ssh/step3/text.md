## Step 3: Explore SSH Configuration

The SSH server (sshd) is configured via `/etc/ssh/sshd_config`. Understanding this file is important for securing servers and troubleshooting connection issues.

### Common settings

| Setting | Default | Meaning |
|---------|---------|---------|
| `Port` | 22 | Which port SSH listens on |
| `PermitRootLogin` | varies | Whether root can SSH in directly |
| `PasswordAuthentication` | yes | Whether passwords are allowed |
| `PubkeyAuthentication` | yes | Whether key-based auth is allowed |

### Explore the config

Take a look at the full config file:

```bash
cat /etc/ssh/sshd_config
```

That's a lot of output. Let's find specific settings using `grep`:

```bash
grep -i "port" /etc/ssh/sshd_config
```

The `-i` flag makes the search case-insensitive.

Many settings are commented out (starting with `#`), meaning they use their default values. To see only uncommented, active lines:

```bash
grep -v "^#" /etc/ssh/sshd_config | grep -v "^$"
```

### Your task

Find the SSH port number from `/etc/ssh/sshd_config` and save **just the number** to `/home/user/ssh-port.txt`.

The default SSH port is 22. Whether it's explicitly set or commented out as the default, save `22` to the file.

<details>
<summary>Hint</summary>

You can extract it with grep, or simply write it since you know the default:

```bash
echo "22" > /home/user/ssh-port.txt
```

To find it programmatically:

```bash
grep "^#\?Port" /etc/ssh/sshd_config | head -1 | awk '{print $2}'
```
</details>
