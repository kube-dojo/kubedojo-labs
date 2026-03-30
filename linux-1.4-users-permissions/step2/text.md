## Step 2: Password and Shadow

Passwords are stored as hashes in `/etc/shadow`, not in `/etc/passwd` (which would be world-readable).

### /etc/shadow format

Each line has fields separated by `:`:

```
username:$hash:last_changed:min_age:max_age:warn:inactive:expire
```

The hash starts with `$6$` (SHA-512), `$5$` (SHA-256), or `$y$` (yescrypt).

### Account management

```bash
passwd developer            # set password
passwd -l developer         # lock account (prepends ! to hash)
passwd -u developer         # unlock account
passwd -S developer         # show account status
```

### Account status codes

- `P` — has a usable password
- `L` — locked
- `NP` — no password set

### Your task

Lock the `developer` account and verify it's locked.

<details>
<summary>Hint</summary>

```bash
passwd -l developer
passwd -S developer
```

The status should show `L` (locked) or `LK`.
</details>
