#!/bin/bash
cat > "$HOME"/broken.yaml << 'EOF'
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
EOF
echo "Fixed "$HOME"/broken.yaml:"
cat "$HOME"/broken.yaml
python3 -c "import yaml; print('Valid YAML:', yaml.safe_load(open('"$HOME"/broken.yaml'))['kind'])"
