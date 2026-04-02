#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: kubelet is active and config file saved
KUBELET_ACTIVE=$(systemctl is-active kubelet)
[ "$KUBELET_ACTIVE" = "active" ] && [ -f $USER_HOME/kubelet-config.txt ] && [ -s $USER_HOME/kubelet-config.txt ] && exit 0 || exit 1
