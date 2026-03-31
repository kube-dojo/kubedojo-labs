#!/bin/bash
kubectl create namespace immutable-enforced 2>/dev/null || true
kubectl label namespace immutable-enforced \
  pod-security.kubernetes.io/enforce=restricted \
  pod-security.kubernetes.io/warn=restricted --overwrite

# Test non-compliant pod (should fail)
kubectl run non-compliant --image=nginx -n immutable-enforced > /root/enforce-test.txt 2>&1 || true

# Create compliant pod
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: compliant-pod
  namespace: immutable-enforced
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: busybox
    image: busybox
    command: ["sleep", "3600"]
    securityContext:
      readOnlyRootFilesystem: true
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
YAML
kubectl wait --for=condition=Ready pod/compliant-pod -n immutable-enforced --timeout=120s 2>/dev/null || true

cat > /root/immutability-patterns.txt << 'PATTERNS'
What makes a container immutable:
- readOnlyRootFilesystem: true — prevents all filesystem writes
- No shell or package manager in the image (distroless)
- allowPrivilegeEscalation: false — prevents gaining write capabilities
- Drop ALL capabilities — removes ability to bypass filesystem restrictions

Handling write-access needs:
1. emptyDir volumes: ephemeral writable space, lost when pod restarts
   - Use for: temp files, caches, PID files, unix sockets
2. configMap/secret volumes: read-only configuration injection
   - Use for: application config, TLS certificates
3. PersistentVolume: persistent writable storage
   - Use for: databases, file uploads (mount only where needed)

Patterns:
- Web server: readOnlyRoot + emptyDir for /tmp, /var/cache, /var/run
- API server: readOnlyRoot + emptyDir for /tmp + configMap for config
- Database: readOnlyRoot + PVC for /data + emptyDir for /tmp
- Sidecar: readOnlyRoot + shared emptyDir with main container
PATTERNS
