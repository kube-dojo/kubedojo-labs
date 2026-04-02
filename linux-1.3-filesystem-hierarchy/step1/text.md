## Step 1: FHS Overview

The **Filesystem Hierarchy Standard** defines where files should go on a Linux system:

| Directory | Purpose |
|-----------|---------|
| `/` | Root of the filesystem |
| `/bin` | Essential binaries (ls, cp, cat) |
| `/sbin` | System binaries (fdisk, iptables) |
| `/etc` | System configuration files |
| `/var` | Variable data (logs, databases, mail) |
| `/tmp` | Temporary files (cleared on reboot) |
| `/home` | User home directories |
| `/usr` | User programs and libraries |
| `/opt` | Optional third-party software |
| `/proc` | Virtual filesystem (kernel/process info) |
| `/sys` | Virtual filesystem (hardware/driver info) |
| `/dev` | Device files |

### Explore

```bash
ls /
ls /etc | head -20
ls /var
```

### Your task

Create a file `~/fhs-quiz.txt` with key=value entries describing the purpose of at least three directories. For example:

```
/etc=system configuration files
/var=variable data like logs
/tmp=temporary files
```

Include entries for `/etc`, `/var`, and `/tmp` at minimum.

<details>
<summary>Hint</summary>

```bash
cat > ~/fhs-quiz.txt << 'EOF'
/etc=system configuration files
/var=variable data like logs and databases
/tmp=temporary files cleared on reboot
EOF
```
</details>
