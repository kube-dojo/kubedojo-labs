#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  IMG=$(kubectl get deployment webapp -n deploy-lab -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
  [ "$IMG" = "nginx:1.24" ] && break
  sleep 2
done
if [ "$IMG" != "nginx:1.24" ]; then
  echo "FAIL: After rollback image should be nginx:1.24, got: $IMG"
  exit 1
fi
if [ ! -f $USER_HOME/rollback-image.txt ]; then
  echo "FAIL: $USER_HOME/rollback-image.txt not found"
  exit 1
fi
echo "PASS"
exit 0
