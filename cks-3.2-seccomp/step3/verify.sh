#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f /var/lib/kubelet/seccomp/profiles/audit.json ]; then
  echo "FAIL: Audit seccomp profile not found"
  exit 1
fi
if ! kubectl get pod audit-pod -n seccomp-lab &>/dev/null; then
  echo "FAIL: Pod audit-pod not found"
  exit 1
fi
if [ ! -f $USER_HOME/seccomp-best-practices.txt ]; then
  echo "FAIL: $USER_HOME/seccomp-best-practices.txt not found"
  exit 1
fi
LINES=$(wc -l < $USER_HOME/seccomp-best-practices.txt | tr -d ' ')
if [ "$LINES" -lt 4 ]; then
  echo "FAIL: Expected at least 4 best practices"
  exit 1
fi
echo "PASS"
exit 0
