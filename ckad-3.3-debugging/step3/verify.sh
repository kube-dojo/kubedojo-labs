#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod debug-target -n debug-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: debug-target should be Running"
  exit 1
fi
if [ ! -f $USER_HOME/nginx-version.txt ]; then
  echo "FAIL: $USER_HOME/nginx-version.txt not found"
  exit 1
fi
if [ ! -f $USER_HOME/nginx-config-list.txt ]; then
  echo "FAIL: $USER_HOME/nginx-config-list.txt not found"
  exit 1
fi
if [ ! -f $USER_HOME/dns-server.txt ]; then
  echo "FAIL: $USER_HOME/dns-server.txt not found"
  exit 1
fi
echo "PASS"
exit 0
