#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: CNI config backup exists
[ -f $USER_HOME/cni-config-backup.json ] && [ -s $USER_HOME/cni-config-backup.json ] && exit 0 || exit 1
