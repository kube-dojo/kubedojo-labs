#!/bin/bash
cat > /root/practice.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: test
EOF
echo "Created /root/practice.yaml"
cat /root/practice.yaml
