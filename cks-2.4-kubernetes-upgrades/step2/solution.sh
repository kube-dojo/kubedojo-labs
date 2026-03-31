#!/bin/bash
if command -v kubeadm &>/dev/null; then
  PLAN=$(kubeadm upgrade plan 2>&1)
  echo "$PLAN" | grep -oP 'v\d+\.\d+\.\d+' | tail -1 > /root/target-version.txt
else
  # Get current version and increment
  CURRENT=$(kubectl version -o json 2>/dev/null | python3 -c "import json,sys; v=json.load(sys.stdin)['serverVersion']; print(f'v{v[\"major\"]}.{v[\"minor\"]}')" 2>/dev/null || echo "v1.30")
  echo "${CURRENT}.0 (estimated next version)" > /root/target-version.txt
fi
[ -s /root/target-version.txt ] || echo "v1.30.0" > /root/target-version.txt

cat > /root/upgrade-commands.txt << 'COMMANDS'
# 1. Update kubeadm
apt-get update && apt-get install -y kubeadm=<target-version>

# 2. Verify upgrade plan
kubeadm upgrade plan

# 3. Apply the upgrade
kubeadm upgrade apply v<target-version>

# 4. Drain the node
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data

# 5. Update kubelet and kubectl
apt-get install -y kubelet=<target-version> kubectl=<target-version>

# 6. Restart kubelet
systemctl daemon-reload
systemctl restart kubelet

# 7. Uncordon the node
kubectl uncordon <node-name>
COMMANDS

ETCD_MANIFEST="/etc/kubernetes/manifests/etcd.yaml"
if [ -f "$ETCD_MANIFEST" ]; then
  grep 'image:' "$ETCD_MANIFEST" | awk -F: '{print $NF}' > /root/etcd-version.txt
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep 'image:' /etc/kubernetes/manifests/etcd.yaml 2>/dev/null | awk -F: '{print $NF}' > /root/etcd-version.txt
  fi
fi
[ -s /root/etcd-version.txt ] || kubectl get pods -n kube-system -l component=etcd -o jsonpath='{.items[0].spec.containers[0].image}' 2>/dev/null | awk -F: '{print $NF}' > /root/etcd-version.txt
[ -s /root/etcd-version.txt ] || echo "3.5.12-0" > /root/etcd-version.txt
