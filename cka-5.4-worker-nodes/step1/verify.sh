#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: node-conditions.txt exists with content
[ -f $USER_HOME/node-conditions.txt ] && [ -s $USER_HOME/node-conditions.txt ] && exit 0 || exit 1
