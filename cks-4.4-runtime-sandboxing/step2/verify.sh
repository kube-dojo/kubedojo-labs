#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get runtimeclass gvisor &>/dev/null; then
  echo "FAIL: RuntimeClass gvisor not found"
  exit 1
fi
if ! kubectl get runtimeclass kata &>/dev/null; then
  echo "FAIL: RuntimeClass kata not found"
  exit 1
fi
if [ ! -f $USER_HOME/sandboxed-pod.yaml ] || [ ! -s $USER_HOME/sandboxed-pod.yaml ]; then
  echo "FAIL: $USER_HOME/sandboxed-pod.yaml missing or empty"
  exit 1
fi
if ! grep -q "runtimeClassName" $USER_HOME/sandboxed-pod.yaml; then
  echo "FAIL: sandboxed-pod.yaml should reference runtimeClassName"
  exit 1
fi
echo "PASS"
exit 0
