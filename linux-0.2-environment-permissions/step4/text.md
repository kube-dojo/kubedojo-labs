## Step 4: ACLs

Standard Unix permissions only support one owner and one group. **POSIX ACLs** (Access Control Lists) let you grant permissions to specific additional users or groups.

### Key commands

```bash
getfacl file.txt          # view ACLs
setfacl -m u:USER:PERM file.txt   # set ACL for a user
setfacl -m g:GROUP:PERM file.txt  # set ACL for a group
setfacl -x u:USER file.txt        # remove ACL for a user
```

### Example

```bash
# Give user "bob" read access to a file
setfacl -m u:bob:r ~/shared.txt

# View the ACL
getfacl ~/shared.txt
```

When a file has ACLs, `ls -l` shows a `+` after the permission string: `-rw-r-----+`.

### Your task

Set an ACL on `~/shared.txt` that gives user `www-data` read access.

Verify with:

```bash
getfacl ~/shared.txt
```

You should see a line like `user:www-data:r--`.

<details>
<summary>Hint</summary>

Use `setfacl` to add the ACL:

```bash
setfacl -m u:www-data:r ~/shared.txt
getfacl ~/shared.txt
```
</details>
