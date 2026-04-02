#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/kustomize/overlays/staging/kustomization.yaml ]; then
  echo "FAIL: staging kustomization not found"
  exit 1
fi
if [ ! -f $USER_HOME/kustomize/overlays/production/kustomization.yaml ]; then
  echo "FAIL: production kustomization not found"
  exit 1
fi
if [ ! -f $USER_HOME/staging-output.yaml ]; then
  echo "FAIL: staging-output.yaml not found"
  exit 1
fi
if ! grep -q "staging-" $USER_HOME/staging-output.yaml; then
  echo "FAIL: staging output should have staging- prefix"
  exit 1
fi
if [ ! -f $USER_HOME/production-output.yaml ]; then
  echo "FAIL: production-output.yaml not found"
  exit 1
fi
if ! grep -q "prod-" $USER_HOME/production-output.yaml; then
  echo "FAIL: production output should have prod- prefix"
  exit 1
fi
echo "PASS"
exit 0
