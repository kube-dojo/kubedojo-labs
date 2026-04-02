# Gather System Information

The first step in troubleshooting is understanding the current state of the system. Create a comprehensive snapshot.

## Key Commands

```bash
hostname                    # System name
uname -a                    # Kernel version
uptime                      # How long running, load average
df -h                       # Disk usage
free -m                     # Memory usage
```

## Your Task

Create a system snapshot report at `~/system-report.txt` containing:

1. **Hostname**
2. **Kernel version** (from `uname -r`)
3. **Uptime**
4. **Disk usage** (from `df -h`)
5. **Memory usage** (from `free -m`)

Format your report with clear headers:

```
=== System Report ===
Hostname: <hostname>
Kernel: <version>
Uptime: <uptime>

=== Disk Usage ===
<df output>

=== Memory ===
<free output>
```
