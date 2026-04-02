# Check Services

A common troubleshooting step is finding failed services.

## Finding Failed Services

```bash
# List failed systemd units
systemctl list-units --failed

# Check a specific service
systemctl status <service-name>
```

If systemd is not available, use process-based checks:

```bash
# Check if a service is running
pgrep -a nginx
ps aux | grep nginx
```

## Your Task

A service has been set up that is failing. Find it!

1. List failed services using `systemctl list-units --failed`
2. Save the name of the failed service to `~/failed-service.txt`

The file should contain just the service name (e.g., `broken-app.service`).
