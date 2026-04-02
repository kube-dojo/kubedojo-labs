#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify K8s seccomp manifest or seccomp profile exists

if [ -f $USER_HOME/k8s-seccomp.yaml ]; then
  if grep -q "seccompProfile" $USER_HOME/k8s-seccomp.yaml; then
    echo "PASS: Kubernetes seccomp manifest exists with seccompProfile"
    exit 0
  else
    echo "FAIL: $USER_HOME/k8s-seccomp.yaml does not contain seccompProfile"
    exit 1
  fi
fi

# Fallback: check if seccomp profile at least exists
if [ -f $USER_HOME/seccomp-profile.json ]; then
  echo "PASS: seccomp profile exists"
  exit 0
fi

echo "FAIL: Neither $USER_HOME/k8s-seccomp.yaml nor $USER_HOME/seccomp-profile.json found"
exit 1
