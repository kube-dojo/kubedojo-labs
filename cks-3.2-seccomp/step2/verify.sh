#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f /var/lib/kubelet/seccomp/profiles/nginx-strict.json ]; then
  echo "FAIL: Custom seccomp profile not found"
  exit 1
fi
if ! kubectl get pod nginx-strict-seccomp -n seccomp-lab &>/dev/null; then
  echo "FAIL: Pod nginx-strict-seccomp not found"
  exit 1
fi
PROFILE=$(kubectl get pod nginx-strict-seccomp -n seccomp-lab -o jsonpath='{.spec.securityContext.seccompProfile.type}')
if [ "$PROFILE" != "Localhost" ]; then
  echo "FAIL: Should use Localhost seccomp profile"
  exit 1
fi
if [ ! -f $USER_HOME/strict-pod-status.txt ] || [ ! -s $USER_HOME/strict-pod-status.txt ]; then
  echo "FAIL: $USER_HOME/strict-pod-status.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
