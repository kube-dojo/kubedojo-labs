#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: no-escalation
  namespace: secctx-lab
spec:
  containers:
  - name: nginx
    image: nginx
    securityContext:
      runAsUser: 101
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
        add: ["NET_BIND_SERVICE"]
YAML
kubectl wait --for=condition=Ready pod/no-escalation -n secctx-lab --timeout=60s
kubectl exec no-escalation -n secctx-lab -- cat /proc/1/status 2>/dev/null | grep Cap > /root/pod-caps.txt || echo "Cannot read caps" > /root/pod-caps.txt

cat > /root/escalation-risks.txt << 'RISKS'
allowPrivilegeEscalation: false prevents:
- setuid/setgid binaries from gaining elevated privileges
- ptrace-based privilege escalation
- no_new_privs flag is set on the process

Dropping all capabilities is important because:
- Default containers get ~14 capabilities including NET_RAW (for ARP spoofing)
- Most applications need only NET_BIND_SERVICE (or none)
- Capabilities like CHOWN, DAC_OVERRIDE bypass file permissions

Most dangerous capabilities:
- SYS_ADMIN: near-root access, mount filesystems, container escape possible
- NET_ADMIN: configure network interfaces, iptables, sniff traffic
- SYS_PTRACE: debug/inspect any process, read memory, container escape possible
RISKS
