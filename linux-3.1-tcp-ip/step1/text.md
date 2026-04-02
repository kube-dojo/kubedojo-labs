# IP Addressing and Subnets

Every network interface on a Linux system has one or more IP addresses. The `ip addr` command (or its shorthand `ip a`) shows all interfaces and their assigned addresses.

## CIDR Notation

IP addresses are paired with a subnet mask written in CIDR (Classless Inter-Domain Routing) notation. For example, `192.168.1.10/24` means:

- **Address**: 192.168.1.10
- **Subnet mask**: /24 = 255.255.255.0
- **Network**: 192.168.1.0/24 (256 addresses, 254 usable)

Common CIDR blocks:
| CIDR | Subnet Mask     | Hosts  |
|------|-----------------|--------|
| /8   | 255.0.0.0       | 16.7M  |
| /16  | 255.255.0.0     | 65,534 |
| /24  | 255.255.255.0   | 254    |
| /32  | 255.255.255.255 | 1      |

## Key Commands

```bash
ip addr show          # Show all interfaces and IPs
ip -4 addr show       # Show only IPv4 addresses
ip addr show eth0     # Show specific interface
```

## Task

List all IP addresses on the system and save the output to `~/all-ips.txt`.

<details>
<summary>Hint 1</summary>
Use <code>ip addr show</code> to display all addresses.
</details>

<details>
<summary>Hint 2</summary>
Redirect the output: <code>ip addr show > ~/all-ips.txt</code>
</details>
