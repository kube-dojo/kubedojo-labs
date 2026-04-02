# lsof — List Open Files

In Linux, "everything is a file" — including network sockets, pipes, and devices. `lsof` lists all files opened by a process.

## Basic Usage

```bash
# All open files for a PID
lsof -p <PID>

# Files opened by a command name
lsof -c bash

# Who has a file open
lsof /var/log/syslog

# Network connections
lsof -i :80        # Who's using port 80
lsof -i -P -n      # All network connections
```

## Your Task

A background process was started during setup. Its PID is in `~/target-pid.txt`.

1. Use `lsof` to list all files opened by that process
2. Save the output to `~/open-files.txt`

```bash
lsof -p $(cat ~/target-pid.txt) > ~/open-files.txt
```
