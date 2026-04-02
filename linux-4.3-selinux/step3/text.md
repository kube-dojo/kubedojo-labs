# Boolean Policies

SELinux booleans are on/off switches that modify policy behaviour without rewriting policy modules. They provide administrators a simple way to toggle specific permissions.

## Key Commands

```bash
# List all booleans
getsebool -a

# Check a specific boolean
getsebool httpd_can_network_connect

# Set a boolean (runtime only)
setsebool httpd_can_network_connect on

# Set a boolean (persistent across reboots)
setsebool -P httpd_can_network_connect on
```

## Common Booleans

| Boolean | Purpose |
|---------|---------|
| `httpd_can_network_connect` | Allow Apache to make outbound network connections |
| `httpd_enable_homedirs` | Allow Apache to serve user home directories |
| `container_manage_cgroup` | Allow containers to manage cgroups |
| `virt_use_nfs` | Allow VMs to use NFS shares |

## Task

1. Try to list all SELinux booleans with `getsebool -a`
2. If SELinux is active, count the total number of booleans
3. If SELinux is not active, document at least 5 important booleans and their purposes
4. Save the result to `~/sebooleans.txt`

<details>
<summary>Refer to: getsebool(8), setsebool(8), semanage-boolean(8)</summary>
See <code>man getsebool</code> for listing booleans. On a system with SELinux disabled, the command may fail — in that case, documenting the common booleans from the table above is the expected approach.
</details>
