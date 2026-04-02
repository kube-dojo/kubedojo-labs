## Step 3: Special Permissions

Beyond the standard rwx bits, Linux has three special permission bits:

| Bit | Octal | On files | On directories |
|-----|-------|----------|----------------|
| **SUID** | 4000 | Run as file owner | (no effect) |
| **SGID** | 2000 | Run as file group | New files inherit group |
| **Sticky** | 1000 | (no effect) | Only owner can delete files |

### SUID in action

The `passwd` command needs to write to `/etc/shadow` (owned by root). It works because it has the SUID bit set:

```bash
ls -la /usr/bin/passwd
```

Notice the `s` in the owner execute position: `-rwsr-xr-x`.

### Finding SUID binaries

SUID binaries are a security audit target — an attacker who finds a vulnerable SUID binary can escalate privileges.

### Your task

Find all SUID binaries on the system and save the list to `~/suid-bins.txt`.

<details>
<summary>Hint</summary>

Use `find` with the `-perm` flag to search for the SUID bit:

```bash
find / -perm -4000 -type f 2>/dev/null > ~/suid-bins.txt
```

The `-4000` matches files where the SUID bit is set.
</details>
