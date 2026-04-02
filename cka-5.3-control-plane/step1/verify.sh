#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: health report file exists
[ -f $USER_HOME/cp-health.txt ] && [ -s $USER_HOME/cp-health.txt ] && exit 0 || exit 1
