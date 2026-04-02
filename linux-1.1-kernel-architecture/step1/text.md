## Step 1: Kernel Version and Modules

The kernel is the core of the operating system. It manages hardware, memory, processes, and system calls.

### Kernel version

```bash
uname -r                   # kernel release version
uname -a                   # all kernel info
```

### Kernel modules

The kernel is modular — functionality can be loaded and unloaded at runtime:

```bash
lsmod                      # list loaded modules
modinfo ext4               # info about a specific module
```

Modules live in `/lib/modules/$(uname -r)/`.

### Your task

1. Save the kernel version to `~/kernel-version.txt`
2. Count the number of loaded kernel modules and save to `~/module-count.txt`

<details>
<summary>Hint</summary>

```bash
uname -r > ~/kernel-version.txt
lsmod | tail -n +2 | wc -l > ~/module-count.txt
```

The `tail -n +2` skips the header line from `lsmod`.
</details>
