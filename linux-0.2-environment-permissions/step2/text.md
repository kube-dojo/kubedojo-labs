## Step 2: File Permissions Deep Dive

Every file has three permission sets: **owner**, **group**, and **others**. Each set can have **read** (r=4), **write** (w=2), and **execute** (x=1).

### Reading permissions

```bash
ls -la /opt/myapp/
```

The permission string `-rwxr-xr--` means:
- Owner: read + write + execute (7)
- Group: read + execute (5)
- Others: read only (4)

### umask

The `umask` controls default permissions for new files. It's a mask that's subtracted from the maximum:

```bash
umask          # show current umask
```

- Files start at 666 (no execute), minus umask
- Directories start at 777, minus umask

For example, `umask 027` means:
- Files: 666 - 027 = 640 (owner: rw, group: r, others: none)
- Directories: 777 - 027 = 750

### Your task

1. Set the umask to `027`
2. Create a new file `/root/umask-test.txt`
3. Verify its permissions are `640` (-rw-r-----)

```bash
stat -c '%a' /root/umask-test.txt
```

<details>
<summary>Hint</summary>

Set the umask before creating the file:

```bash
umask 027
touch /root/umask-test.txt
stat -c '%a' /root/umask-test.txt
```

The output should show `640`.
</details>
