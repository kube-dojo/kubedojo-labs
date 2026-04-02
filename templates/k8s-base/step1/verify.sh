#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify step completion
# Exit 0 = pass, Exit 1 = fail
# Use exact checks, not string matching on output

# Example: check if a file exists
# [ -f $USER_HOME/myfile.txt ] && exit 0 || exit 1

echo "TODO: Add verification"
exit 1
