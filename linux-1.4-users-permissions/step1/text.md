## Step 1: Users and Groups

Linux uses **users** and **groups** for identity. Every file and process is associated with a user and group.

### Key files

- `/etc/passwd` — user accounts (name, UID, GID, home, shell)
- `/etc/group` — group definitions
- `/etc/shadow` — encrypted passwords (root-only)

### Managing users

```bash
useradd developer                   # create user
useradd -m -s /bin/bash developer   # with home dir and bash shell
usermod -aG devteam developer       # add to supplementary group
userdel developer                   # delete user
```

### Managing groups

```bash
groupadd devteam                    # create group
groupdel devteam                    # delete group
```

### Checking identity

```bash
id                                  # current user's UID, GID, groups
id developer                       # another user's info
whoami                             # just the username
groups developer                   # list groups for a user
```

### Your task

1. Create a group called `devteam`
2. Create a user called `developer` with `/bin/bash` as shell
3. Add `developer` to the `devteam` group

<details>
<summary>Hint</summary>

```bash
groupadd devteam
useradd -m -s /bin/bash -G devteam developer
```

Or create user first, then add to group:

```bash
groupadd devteam
useradd -m -s /bin/bash developer
usermod -aG devteam developer
```
</details>
