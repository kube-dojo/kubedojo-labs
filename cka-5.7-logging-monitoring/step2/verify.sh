#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: events.txt exists with content
[ -f $USER_HOME/events.txt ] && [ -s $USER_HOME/events.txt ] && exit 0 || exit 1
