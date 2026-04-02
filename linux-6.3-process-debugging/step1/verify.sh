#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/strace-output.txt ]; then
  echo "FAIL: $USER_HOME/strace-output.txt not found"
  exit 1
fi

if grep -qE '(open|read|write|execve|stat|mmap)' $USER_HOME/strace-output.txt; then
  echo "PASS: strace output contains system calls"
  exit 0
else
  echo "FAIL: strace output does not contain expected syscalls"
  exit 1
fi
