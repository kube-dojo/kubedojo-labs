## Step 4: dmesg and Kernel Logs

The kernel writes messages to a **ring buffer** — a fixed-size circular log. `dmesg` reads this buffer.

### Viewing kernel messages

```bash
dmesg                      # all kernel messages
dmesg | tail -20           # last 20 messages
dmesg -T                   # human-readable timestamps
dmesg -l err               # only errors
dmesg -l warn              # only warnings
```

### What you'll find in dmesg

- Boot messages (hardware detection, driver loading)
- USB device connections/disconnections
- Filesystem errors
- Out-of-memory (OOM) kills
- Network interface changes

### Kernel logs via journalctl

```bash
journalctl -k              # same as dmesg but via journald
journalctl -k -p err       # kernel errors only
```

### Your task

Save the last 20 lines of `dmesg` output to `~/dmesg-tail.txt`.

<details>
<summary>Hint</summary>

```bash
dmesg | tail -20 > ~/dmesg-tail.txt
```
</details>
