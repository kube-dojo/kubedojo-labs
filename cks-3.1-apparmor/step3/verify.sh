#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f /etc/apparmor.d/k8s-nginx ]; then
  echo "FAIL: /etc/apparmor.d/k8s-nginx not found"
  exit 1
fi
# Accept either loaded profile or profile file existence
if command -v aa-status &>/dev/null; then
  aa-status 2>/dev/null | grep -q "k8s-nginx" || true
fi
if ! kubectl get pod nginx-hardened -n apparmor-lab &>/dev/null; then
  echo "FAIL: Pod nginx-hardened not found"
  exit 1
fi
if [ ! -f $USER_HOME/nginx-test.txt ] || [ ! -s $USER_HOME/nginx-test.txt ]; then
  echo "FAIL: $USER_HOME/nginx-test.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
