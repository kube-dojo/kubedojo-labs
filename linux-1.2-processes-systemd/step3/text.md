## Step 3: systemd Dependencies

systemd units can declare dependencies on other units. This creates a **dependency graph** that determines boot order.

### Dependency directives

In a unit file's `[Unit]` section:

- **`Requires=`** — hard dependency (if B fails, A fails too)
- **`Wants=`** — soft dependency (if B fails, A still starts)
- **`After=`** — ordering (start A after B is started)
- **`Before=`** — ordering (start A before B)

### Viewing dependencies

```bash
systemctl list-dependencies multi-user.target    # tree view
systemctl list-dependencies sshd.service         # what does sshd need?
```

### Targets as milestones

Targets group units. The key targets in boot order:
1. `sysinit.target` — early system initialization
2. `basic.target` — basic system ready
3. `network.target` — networking available
4. `multi-user.target` — full multi-user mode (like old runlevel 3)
5. `graphical.target` — GUI ready (like old runlevel 5)

### Your task

Show the dependencies of `multi-user.target` and save to `/root/multiuser-deps.txt`.

<details>
<summary>Hint</summary>

```bash
systemctl list-dependencies multi-user.target --no-pager > /root/multiuser-deps.txt
```
</details>
