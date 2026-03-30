# Explore etcd

etcd is the key-value store that holds all cluster state. Understanding how to interact with it is important for backup/restore scenarios on the CKA exam.

**Key information:**
- etcd listens on port `2379` for client connections
- The endpoint URL is configured in the etcd static pod manifest
- etcd uses TLS certificates for authentication

## Task

Find the etcd endpoint URL (the `--listen-client-urls` flag) from the etcd configuration and save it to `/root/etcd-endpoint.txt`.

You can find this in the etcd static pod manifest at `/etc/kubernetes/manifests/etcd.yaml` or by describing the etcd pod.

## Hint

Look at the etcd pod manifest: `cat /etc/kubernetes/manifests/etcd.yaml | grep listen-client-urls`. The endpoint typically looks like `https://127.0.0.1:2379`.
