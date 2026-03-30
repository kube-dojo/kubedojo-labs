# Kernel Parameters

The `sysctl` interface exposes kernel parameters at runtime via the `/proc/sys/` virtual filesystem. Many of these parameters control network stack behaviour and are critical for security hardening.

## Key Security Parameters

| Parameter | Secure Value | Purpose |
|-----------|-------------|---------|
| `net.ipv4.ip_forward` | 0 | Disables IP forwarding (prevents routing between interfaces) |
| `net.ipv4.tcp_syncookies` | 1 | Protects against SYN flood attacks |
| `net.ipv4.conf.all.accept_redirects` | 0 | Ignores ICMP redirects (prevents route poisoning) |
| `net.ipv4.conf.all.send_redirects` | 0 | Disables sending ICMP redirects |

## Reading Current Values

```bash
sysctl net.ipv4.ip_forward
sysctl -a | grep syncookies
cat /proc/sys/net/ipv4/ip_forward
```

## Setting Values

```bash
sysctl -w net.ipv4.ip_forward=0       # Runtime change (lost on reboot)
```

To persist across reboots, write settings to a file in `/etc/sysctl.d/`.

## Task

1. Set `net.ipv4.ip_forward` to `0` (disable IP forwarding)
2. Set `net.ipv4.tcp_syncookies` to `1` (enable SYN cookies)
3. Set `net.ipv4.conf.all.accept_redirects` to `0` (disable ICMP redirects)
4. Save all three settings to `/etc/sysctl.d/99-hardening.conf` so they persist across reboots
5. Apply the settings with `sysctl -p /etc/sysctl.d/99-hardening.conf`

<details>
<summary>Refer to: sysctl(8), sysctl.d(5)</summary>
See <code>man sysctl</code> for runtime parameter changes. The <code>/etc/sysctl.d/</code> directory is documented in <code>man sysctl.d</code>.
</details>
