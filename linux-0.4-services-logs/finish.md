## Lab Complete!

You've conquered systemd and logging:

- **Service management**: `systemctl start/stop/enable/status` — control the service lifecycle
- **Journal**: `journalctl -u`, `-f`, `--since` — query structured logs
- **Custom units**: Write your own `.service` files with `ExecStart`, `Restart`
- **Log analysis**: `grep`, pattern counting, logrotate

In Kubernetes, kubelet and container runtime are systemd services. Understanding unit files helps debug node-level issues.

### Next Steps

- **Next lab**: [Networking Tools](https://killercoda.com/kubedojo/scenario/linux-0.5-networking-tools) — ip, dig, curl, ss
- **Theory**: [Module 0.4: Services and Logs](https://kube-dojo.github.io/linux/foundations/everyday-use/module-0.4-services-logs/) on KubeDojo
- **Track progress**: Mark this lab complete on your [KubeDojo dashboard](https://kube-dojo.github.io/)
