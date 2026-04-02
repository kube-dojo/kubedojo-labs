#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: app-logs.txt exists with content
[ -f $USER_HOME/app-logs.txt ] && [ -s $USER_HOME/app-logs.txt ] && exit 0 || exit 1
