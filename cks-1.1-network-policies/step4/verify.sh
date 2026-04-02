#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get networkpolicy db-policy -n backend &>/dev/null; then
  echo "FAIL: NetworkPolicy db-policy not found"
  exit 1
fi
if [ ! -f $USER_HOME/netpol-summary.txt ] || [ ! -s $USER_HOME/netpol-summary.txt ]; then
  echo "FAIL: $USER_HOME/netpol-summary.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/traffic-matrix.txt ] || [ ! -s $USER_HOME/traffic-matrix.txt ]; then
  echo "FAIL: $USER_HOME/traffic-matrix.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
