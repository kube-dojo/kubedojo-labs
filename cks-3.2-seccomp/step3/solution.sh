#!/bin/bash
cat > /var/lib/kubelet/seccomp/profiles/audit.json << 'JSON'
{
  "defaultAction": "SCMP_ACT_LOG"
}
JSON

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: audit-pod
  namespace: seccomp-lab
spec:
  securityContext:
    seccompProfile:
      type: Localhost
      localhostProfile: profiles/audit.json
  containers:
  - name: nginx
    image: nginx
YAML
kubectl wait --for=condition=Ready pod/audit-pod -n seccomp-lab --timeout=60s 2>&1 || true

cat > /root/seccomp-best-practices.txt << 'BEST'
1. Use RuntimeDefault as the minimum baseline for all pods
2. Create custom Localhost profiles for sensitive workloads with minimal syscall allow-lists
3. Use audit mode (SCMP_ACT_LOG) to discover required syscalls before enforcing
4. Store custom profiles on all nodes or use a seccomp profile operator
5. Test profiles thoroughly in staging before applying to production
6. Combine seccomp with AppArmor and capabilities for defense in depth
BEST
