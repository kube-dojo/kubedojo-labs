#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
TYPE=$(kubectl get svc web-clusterip -n svc-lab -o jsonpath='{.spec.type}' 2>/dev/null)
if [ "$TYPE" != "ClusterIP" ]; then
  echo "FAIL: web-clusterip should be ClusterIP type, got: $TYPE"
  exit 1
fi
if [ ! -f $USER_HOME/cluster-ip.txt ]; then
  echo "FAIL: $USER_HOME/cluster-ip.txt not found"
  exit 1
fi
if [ ! -f $USER_HOME/svc-type.txt ]; then
  echo "FAIL: $USER_HOME/svc-type.txt not found"
  exit 1
fi
echo "PASS"
exit 0
