#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: multi-secure
  namespace: secctx-lab
spec:
  securityContext:
    runAsNonRoot: true
    fsGroup: 2000
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: app
    image: busybox
    command: ["sleep", "3600"]
    securityContext:
      runAsUser: 1000
      readOnlyRootFilesystem: true
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
    volumeMounts:
    - name: data
      mountPath: /data
  - name: sidecar
    image: busybox
    command: ["sleep", "3600"]
    securityContext:
      runAsUser: 1001
      readOnlyRootFilesystem: true
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    emptyDir: {}
YAML
kubectl wait --for=condition=Ready pod/multi-secure -n secctx-lab --timeout=60s
{
  echo "=== app container ==="
  kubectl exec multi-secure -n secctx-lab -c app -- id
  echo "=== sidecar container ==="
  kubectl exec multi-secure -n secctx-lab -c sidecar -- id
} > /root/multi-ids.txt

{
  kubectl exec multi-secure -n secctx-lab -c app -- sh -c 'echo "written by app" > /data/test.txt && cat /data/test.txt'
  kubectl exec multi-secure -n secctx-lab -c sidecar -- cat /data/test.txt
  kubectl exec multi-secure -n secctx-lab -c sidecar -- sh -c 'echo "written by sidecar" >> /data/test.txt && cat /data/test.txt'
} > /root/shared-volume-test.txt 2>&1
