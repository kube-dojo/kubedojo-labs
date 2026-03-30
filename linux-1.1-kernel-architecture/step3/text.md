## Step 3: Kernel Parameters

The kernel exposes tunable parameters via `sysctl` and `/proc/sys/`. These control networking behavior, memory management, security, and more.

### Reading parameters

```bash
sysctl -a                              # list ALL parameters
sysctl net.ipv4.ip_forward            # read one parameter
cat /proc/sys/net/ipv4/ip_forward     # same thing via /proc
```

### Setting parameters (runtime)

```bash
sysctl -w net.ipv4.ip_forward=1       # enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward  # same thing via /proc
```

### Persisting parameters

Add to `/etc/sysctl.conf` or a file in `/etc/sysctl.d/`:

```bash
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p   # reload
```

### Important parameters for Kubernetes

- `net.ipv4.ip_forward` — must be `1` for pod networking
- `net.bridge.bridge-nf-call-iptables` — must be `1` for kube-proxy
- `vm.swappiness` — kubelet requires swap to be off or properly configured

### Your task

Read the current value of `net.ipv4.ip_forward` and save it to `/root/ip-forward.txt`.

<details>
<summary>Hint</summary>

```bash
sysctl -n net.ipv4.ip_forward > /root/ip-forward.txt
```

Or:

```bash
cat /proc/sys/net/ipv4/ip_forward > /root/ip-forward.txt
```
</details>
