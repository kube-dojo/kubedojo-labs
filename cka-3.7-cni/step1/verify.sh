#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: cni-plugin.txt exists and contains a valid plugin name
if [ -f $USER_HOME/cni-plugin.txt ]; then
  PLUGIN=$(cat $USER_HOME/cni-plugin.txt | tr -d '[:space:]')
  echo "$PLUGIN" | grep -qiE "calico|flannel|weave|cilium|kindnet|bridge" && exit 0
fi
exit 1
