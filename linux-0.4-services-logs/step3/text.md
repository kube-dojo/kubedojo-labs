## Step 3: Creating a systemd Service

You can create your own services by writing a **unit file**. This is how production applications are managed on Linux.

### Unit file structure

A basic service unit file goes in `/etc/systemd/system/`:

```ini
[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
ExecStart=/path/to/script
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

Key directives:
- **ExecStart** — command to run
- **Restart** — when to restart: `always`, `on-failure`, `no`
- **WantedBy** — which target pulls in this service

### After creating the file

```bash
systemctl daemon-reload    # reload unit files
systemctl start myservice  # start the service
systemctl enable myservice # enable on boot
```

### Your task

A script already exists at `/opt/myservice/run.sh`. Create a systemd service called `myservice` that runs it, then start it.

<details>
<summary>Hint</summary>

Create the unit file:

```bash
cat > /etc/systemd/system/myservice.service << 'EOF'
[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
ExecStart=/opt/myservice/run.sh
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start myservice
```
</details>
