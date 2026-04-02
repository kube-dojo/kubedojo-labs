#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: etcd backup file exists
[ -f $USER_HOME/etcd-backup.db ] && [ -s $USER_HOME/etcd-backup.db ] && exit 0 || exit 1
