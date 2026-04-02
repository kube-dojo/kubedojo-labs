#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: resource-usage.txt exists with content
[ -f $USER_HOME/resource-usage.txt ] && [ -s $USER_HOME/resource-usage.txt ] && exit 0 || exit 1
