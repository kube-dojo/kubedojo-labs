## Step 3: File Permissions

Every file on Linux has permissions that control who can read, write, and execute it. The `chmod` command changes these permissions.

### Check current permissions

Look at the permissions on the lab files:

```bash
cd /home/user/lab-workspace
ls -la secret_config.cfg important_script.sh
```

- `secret_config.cfg` shows `----------` -- **no one** can read, write, or execute it (chmod 000)
- `important_script.sh` shows `-rw-r--r--` -- everyone can read, but only the owner can write (chmod 644)

### Make a file private

Set `secret_config.cfg` so only the owner can read and write it (no one else):

```bash
chmod 600 secret_config.cfg
```

Verify:

```bash
ls -l secret_config.cfg
```

You should see `-rw-------` -- owner can read/write, no access for group or others.

### Make a script executable

The `important_script.sh` file can't be executed yet. Add execute permission for the owner:

```bash
chmod u+x important_script.sh
```

Verify:

```bash
ls -l important_script.sh
```

You should see `-rwxr--r--` -- the `x` in the owner section means it's now executable.

### Permission reference

| Number | Permission | Meaning |
|--------|-----------|---------|
| `7` | `rwx` | Read + Write + Execute |
| `6` | `rw-` | Read + Write |
| `5` | `r-x` | Read + Execute |
| `4` | `r--` | Read only |
| `0` | `---` | No access |

### Your task

Make sure you have:
1. Set `secret_config.cfg` to `600` (owner read/write only)
2. Added execute permission to `important_script.sh` for the owner

<details>
<summary>Hint</summary>

```bash
chmod 600 secret_config.cfg
chmod u+x important_script.sh
```
</details>
