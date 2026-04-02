# Nice and ionice Priority Adjustment

## nice — CPU Priority

The `nice` value ranges from -20 (highest priority) to 19 (lowest). Default is 0.

```bash
# Start with lower priority (higher nice value)
nice -n 10 <command>

# Start with higher priority (requires root)
nice -n -10 <command>
```

Change priority of a running process with `renice`:

```bash
renice -n 5 -p <PID>
```

## ionice — I/O Priority

`ionice` sets the I/O scheduling class and priority:

```bash
# Best-effort, priority 0 (highest in class)
ionice -c 2 -n 0 <command>

# Idle — only gets I/O when no one else needs it
ionice -c 3 <command>
```

## Your Task

1. Start a process with nice value -10 (high priority):
   ```bash
   nice -n -10 sleep 300 &
   ```
2. Save the PID and nice value to `~/nice-process.txt` in the format:
   ```
   PID: <pid>
   Nice: -10
   ```

**Hint:** Use `ps -o pid,ni -p <PID>` to verify the nice value.
