#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: backup and config files exist
# Check backup exists (may be from static manifest or pod spec)
[ -f $USER_HOME/kube-apiserver-backup.yaml ] || exit 1
[ -f $USER_HOME/apiserver-config.txt ] || exit 1
# Accept non-empty OR fallback message
[ -s $USER_HOME/apiserver-config.txt ] && exit 0
exit 1
