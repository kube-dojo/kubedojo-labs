#!/bin/bash
PROFILE_DIR="/var/lib/kubelet/seccomp/profiles"
NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)

AUDIT_JSON='{"defaultAction": "SCMP_ACT_LOG"}'

mkdir -p "$PROFILE_DIR"
echo "$AUDIT_JSON" > "$PROFILE_DIR/audit.json"

if [ -n "$NODE" ]; then
  docker exec "$NODE" mkdir -p "$PROFILE_DIR" 2>/dev/null
  docker exec -i "$NODE" sh -c "cat > $PROFILE_DIR/audit.json" <<< "$AUDIT_JSON" 2>/dev/null
fi

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

for i in $(seq 1 30); do
  STATUS=$(kubectl get pod audit-pod -n seccomp-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done

cat > /root/seccomp-best-practices.txt << 'BEST'
1. Use RuntimeDefault as the minimum baseline for all pods
2. Create custom Localhost profiles for sensitive workloads with minimal syscall allow-lists
3. Use audit mode (SCMP_ACT_LOG) to discover required syscalls before enforcing
4. Store custom profiles on all nodes or use a seccomp profile operator
5. Test profiles thoroughly in staging before applying to production
6. Combine seccomp with AppArmor and capabilities for defense in depth
BEST
