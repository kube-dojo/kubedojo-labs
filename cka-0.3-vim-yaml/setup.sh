#!/bin/bash
# Install python3-yaml for YAML validation
apt-get update -qq && apt-get install -y -qq python3-yaml vim > /dev/null 2>&1

# Create broken YAML file for step 2 (each learner home).
_BROKEN=$(mktemp)
cat > "$_BROKEN" << 'YAMLEOF'
apiVersion: v1
kind: Pod
metadata:
name: broken-pod
  labels:
      app: test
spec:
  containers:
    - name: nginx
    image: nginx:1.27
      ports:
      - containerPort: 80
YAMLEOF
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  cp "$_BROKEN" "$home/broken.yaml"
done
rm -f "$_BROKEN"

echo "Environment ready!"

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
