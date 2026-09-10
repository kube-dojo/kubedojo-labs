# Grant One Power: File Capabilities

Binding a port below 1024 needs `CAP_NET_BIND_SERVICE`. The historical fix was setuid-root — which hands the program *every* root power. A file capability attaches just the one needed privilege to the binary: an exploited web server with `cap_net_bind_service` cannot trace processes, change ownership, or load modules.

The lab setup seeded the module's demo program at `/opt/kd-caps/test-bind.c` (binds TCP port 88). It lives under `/opt` on purpose: file capabilities are stored as the `security.capability` xattr and are **silently ignored on `nosuid` mounts**, which `/tmp` often is.

## Task

1. Compile it: `/opt/kd-caps/bind88`.
2. Run it as the unprivileged user `nobody` and record the output into `/tmp/kd-caps/bind-before.txt` (on a standard host it fails with `Permission denied`; some container environments allow unprivileged low ports — record whatever actually happened).
3. Attach the capability: `setcap 'cap_net_bind_service=+ep' /opt/kd-caps/bind88`, and record `getcap` output into `/tmp/kd-caps/getcap.txt`.
4. Run it as `nobody` again — it must print `bound port 88 OK`; record into `/tmp/kd-caps/bind-after.txt`.

The verifier re-reads the live file capability AND re-executes the binary as `nobody`, so the grant must really be in place.

<details>
<summary>Hint</summary>

```bash
sudo gcc /opt/kd-caps/test-bind.c -o /opt/kd-caps/bind88
sudo -u nobody /opt/kd-caps/bind88 > /tmp/kd-caps/bind-before.txt 2>&1 || true
sudo setcap 'cap_net_bind_service=+ep' /opt/kd-caps/bind88
getcap /opt/kd-caps/bind88 > /tmp/kd-caps/getcap.txt
sudo -u nobody /opt/kd-caps/bind88 > /tmp/kd-caps/bind-after.txt 2>&1
cat /tmp/kd-caps/getcap.txt /tmp/kd-caps/bind-after.txt
```

</details>
