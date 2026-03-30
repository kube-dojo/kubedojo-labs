## Step 1: Process Listing and Tree

Every program you run becomes a process with a unique **PID** (Process ID). Process 1 is special — it's the first process started by the kernel.

### List all processes

```bash
ps aux
```

The columns: USER, PID, %CPU, %MEM, VSZ, RSS, TTY, STAT, START, TIME, COMMAND.

### Process tree

See the parent-child relationship between processes:

```bash
pstree
```

Or with PIDs:

```bash
pstree -p
```

### The init process

PID 1 is the **init system** — usually `systemd` on modern Linux. It's the ancestor of all other processes.

```bash
ps -p 1 -o comm=
```

### Your task

Find the name of the PID 1 process and save it to `/root/init-name.txt`.

<details>
<summary>Hint</summary>

Use `ps` to query PID 1:

```bash
ps -p 1 -o comm= > /root/init-name.txt
```

Or read it from `/proc`:

```bash
cat /proc/1/comm > /root/init-name.txt
```
</details>
