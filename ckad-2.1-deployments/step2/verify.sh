#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
IMG=$(kubectl get deployment webapp -n deploy-lab -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
if [ "$IMG" != "nginx:1.25" ]; then
  echo "FAIL: Image should be nginx:1.25, got: $IMG"
  exit 1
fi
if [ ! -f $USER_HOME/rollout-status.txt ]; then
  echo "FAIL: $USER_HOME/rollout-status.txt not found"
  exit 1
fi
echo "PASS"
exit 0
