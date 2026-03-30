## Step 2: Signals and Job Control

Signals are how processes communicate. The most common ones:

| Signal | Number | Default action | Use case |
|--------|--------|---------------|----------|
| SIGTERM | 15 | Terminate gracefully | `kill PID` |
| SIGKILL | 9 | Force kill immediately | `kill -9 PID` |
| SIGHUP | 1 | Hangup / reload config | `kill -HUP PID` |
| SIGSTOP | 19 | Pause process | `kill -STOP PID` |
| SIGCONT | 18 | Resume process | `kill -CONT PID` |

### Background processes

```bash
sleep 300 &           # start in background
jobs                  # list background jobs
fg %1                 # bring job 1 to foreground
```

### Your task

1. Start a `sleep 600` process in the background
2. Save its PID to `/root/bg-pid.txt`
3. Kill it using `kill`
4. Verify it's gone

<details>
<summary>Hint</summary>

The `$!` variable holds the PID of the last background process:

```bash
sleep 600 &
echo $! > /root/bg-pid.txt
kill $(cat /root/bg-pid.txt)
```
</details>
