# Saving and Restoring Rules

iptables rules live in kernel memory — they are lost on reboot unless explicitly saved. Linux provides `iptables-save` and `iptables-restore` for this purpose.

## Saving Rules

```bash
iptables-save > ~/my-rules.txt
```

This saves ALL tables (filter, nat, mangle, raw) in a format that can be restored later.

## Restoring Rules

```bash
iptables-restore < ~/my-rules.txt
```

## Persistent Rules on Ubuntu

For automatic restore on boot, install `iptables-persistent`:

```bash
apt-get install iptables-persistent
# Rules are saved to /etc/iptables/rules.v4
```

## The Save Format

The saved file uses a compact format:

```
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -p tcp -m tcp --dport 8080 -j DROP
COMMIT
```

Each table starts with `*tablename` and ends with `COMMIT`.

## Task

Save all current iptables rules (all tables) to `~/iptables-backup.txt` using `iptables-save`.

<details>
<summary>Refer to: iptables-save(8) man page</summary>
<code>iptables-save</code> outputs all rules in a restorable format. Redirect to a file to persist them.
</details>
