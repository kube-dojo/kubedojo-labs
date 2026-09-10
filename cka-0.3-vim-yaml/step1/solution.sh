#!/bin/bash
cat > "$HOME"/practice.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: test
EOF
echo "Created $HOME/practice.yaml"
cat "$HOME"/practice.yaml
