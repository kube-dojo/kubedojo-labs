#!/bin/bash
crictl pull nginx:latest 2>/dev/null || true
DIGEST=$(crictl inspecti nginx:latest 2>/dev/null | grep -o 'sha256:[a-f0-9]*' | head -1)
if [ -z "$DIGEST" ]; then
  DIGEST=$(crictl images | grep nginx | awk '{print $3}' | head -1)
  DIGEST="sha256:$DIGEST"
fi
echo "$DIGEST" > /root/nginx-digest.txt

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pinned-pod
  namespace: image-lab
spec:
  containers:
  - name: nginx
    image: nginx@${DIGEST}
YAML
kubectl wait --for=condition=Ready pod/pinned-pod -n image-lab --timeout=60s 2>&1 || true
kubectl get pod pinned-pod -n image-lab -o jsonpath='{.spec.containers[0].image}' > /root/pinned-image.txt

cat > /root/image-tag-risks.txt << 'RISKS'
1. Tags are mutable — the same tag can point to a different image after a rebuild
2. latest tag does not guarantee the newest version and may be cached
3. An attacker who compromises a registry can replace a tagged image with malware
4. Tags prevent reproducible deployments — the same manifest may deploy different code
5. No cryptographic verification that the image content matches expectations
RISKS
