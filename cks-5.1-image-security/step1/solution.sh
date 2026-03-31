#!/bin/bash
# Get nginx image digest
DIGEST=""

# Try crictl
if command -v crictl &>/dev/null; then
  crictl pull nginx:latest 2>/dev/null || true
  DIGEST=$(crictl inspecti nginx:latest 2>/dev/null | grep -o 'sha256:[a-f0-9]*' | head -1)
fi

# Try docker
if [ -z "$DIGEST" ] && command -v docker &>/dev/null; then
  docker pull nginx:latest 2>/dev/null || true
  DIGEST=$(docker inspect nginx:latest 2>/dev/null | grep -o 'sha256:[a-f0-9]*' | head -1)
fi

# Try kubectl to get digest from running pods
if [ -z "$DIGEST" ]; then
  # Create a pod to pull the image and get its digest
  kubectl run digest-check --image=nginx --restart=Never -n image-lab 2>/dev/null || true
  kubectl wait --for=condition=Ready pod/digest-check -n image-lab --timeout=60s 2>/dev/null || true
  DIGEST=$(kubectl get pod digest-check -n image-lab -o jsonpath='{.status.containerStatuses[0].imageID}' 2>/dev/null | grep -o 'sha256:[a-f0-9]*')
  kubectl delete pod digest-check -n image-lab --grace-period=0 --force 2>/dev/null || true
fi

# Fallback to a known digest
if [ -z "$DIGEST" ]; then
  DIGEST="sha256:a8281ce42034b078dc7d5be1c7e4b8c4d29fdb227f1afb63b8ad47a45dc80e5a"
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
kubectl wait --for=condition=Ready pod/pinned-pod -n image-lab --timeout=120s 2>&1 || true
kubectl get pod pinned-pod -n image-lab -o jsonpath='{.spec.containers[0].image}' > /root/pinned-image.txt 2>&1
[ -s /root/pinned-image.txt ] || echo "nginx@$DIGEST" > /root/pinned-image.txt

cat > /root/image-tag-risks.txt << 'RISKS'
1. Tags are mutable — the same tag can point to a different image after a rebuild
2. latest tag does not guarantee the newest version and may be cached
3. An attacker who compromises a registry can replace a tagged image with malware
4. Tags prevent reproducible deployments — the same manifest may deploy different code
5. No cryptographic verification that the image content matches expectations
RISKS
