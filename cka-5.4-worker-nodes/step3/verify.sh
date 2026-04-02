#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: resource report exists with capacity info
[ -f $USER_HOME/resource-report.txt ] && grep -q "Capacity" $USER_HOME/resource-report.txt && exit 0 || exit 1
