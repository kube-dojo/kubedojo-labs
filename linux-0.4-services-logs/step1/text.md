## Step 1: systemd Basics

**systemd** is the init system on modern Linux. It manages services (daemons), mounts, timers, and more.

### Key commands

```bash
systemctl status nginx       # show service status
systemctl start nginx        # start a service
systemctl stop nginx         # stop a service
systemctl restart nginx      # restart a service
systemctl enable nginx       # start on boot
systemctl disable nginx      # don't start on boot
systemctl is-active nginx    # just print "active" or "inactive"
systemctl list-units --type=service   # list all services
```

### Service states

- **active (running)** — the service is running
- **inactive (dead)** — the service is stopped
- **enabled** — will start on boot
- **disabled** — won't start on boot

### Your task

1. Start the nginx service
2. Enable it so it starts on boot
3. Verify it's running

<details>
<summary>Hint</summary>

```bash
systemctl start nginx
systemctl enable nginx
systemctl is-active nginx
```
</details>
