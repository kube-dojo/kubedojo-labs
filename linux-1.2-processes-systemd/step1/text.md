## Step 1: Process States

Every process on Linux is in one of these states:

| State | Code | Meaning |
|-------|------|---------|
| Running | R | Actively executing or ready to run |
| Sleeping | S | Waiting for an event (interruptible) |
| Disk sleep | D | Waiting for I/O (uninterruptible) |
| Stopped | T | Paused by signal (SIGSTOP/SIGTSTP) |
| Zombie | Z | Finished but parent hasn't read exit status |

### Viewing process states

```bash
ps aux                     # STAT column shows state
ps -eo pid,stat,comm       # focused view
```

The STAT column often has modifiers:
- `Ss` — sleeping, session leader
- `R+` — running, foreground
- `Sl` — sleeping, multi-threaded

### Your task

List all unique process states currently in use on the system and save them to `/root/process-states.txt` (one state code per line, e.g., `S`, `R`, `I`).

<details>
<summary>Hint</summary>

Extract the first character of the STAT column:

```bash
ps -eo stat --no-headers | cut -c1 | sort -u > /root/process-states.txt
```
</details>
