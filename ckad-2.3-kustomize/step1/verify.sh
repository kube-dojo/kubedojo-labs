#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/kustomize/base/kustomization.yaml ]; then
  echo "FAIL: $USER_HOME/kustomize/base/kustomization.yaml not found"
  exit 1
fi
if [ ! -f $USER_HOME/kustomize/base/deployment.yaml ]; then
  echo "FAIL: deployment.yaml not found in base"
  exit 1
fi
if [ ! -f $USER_HOME/base-output.yaml ]; then
  echo "FAIL: $USER_HOME/base-output.yaml not found"
  exit 1
fi
if ! grep -q "kind: Deployment" $USER_HOME/base-output.yaml; then
  echo "FAIL: base-output.yaml should contain Deployment"
  exit 1
fi
echo "PASS"
exit 0
