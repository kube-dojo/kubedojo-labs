# Restrict Kernel Modules

Loadable kernel modules extend kernel functionality at runtime. While powerful, unnecessary modules increase the attack surface. An attacker who gains root access could load a malicious module to install a rootkit or enable unwanted hardware interfaces.

## The modprobe Blacklist

The `modprobe` utility loads and removes kernel modules. You can prevent specific modules from being loaded by adding them to a blacklist file in `/etc/modprobe.d/`.

```bash
# List currently loaded modules
lsmod

# Show info about a module
modinfo usb-storage

# Blacklist format in /etc/modprobe.d/*.conf
# blacklist <module_name>
```

## Common Modules to Blacklist

| Module | Reason to Blacklist |
|--------|-------------------|
| `usb-storage` | Prevents USB mass storage devices (data exfiltration) |
| `firewire-core` | Firewire DMA attacks |
| `cramfs` | Rarely needed filesystem, reduces attack surface |
| `freevxfs` | Rarely needed filesystem |

## Task

Create a blacklist file at `/etc/modprobe.d/blacklist-custom.conf` that blacklists the `usb-storage` module.

The file should contain a line in the format: `blacklist usb-storage`

<details>
<summary>Refer to: modprobe.d(5)</summary>
See <code>man modprobe.d</code> for the blacklist file format. Each line should start with the <code>blacklist</code> keyword followed by the module name.
</details>
