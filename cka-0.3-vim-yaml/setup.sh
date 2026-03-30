#!/bin/bash
# Install python3-yaml for YAML validation
apt-get update -qq && apt-get install -y -qq python3-yaml vim > /dev/null 2>&1

# Create broken YAML file for step 2
cat > /root/broken.yaml << 'YAMLEOF'
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

echo "Environment ready!"
