#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/.vimrc ]; then
  echo "FAIL: $USER_HOME/.vimrc does not exist"
  exit 1
fi

if grep -q "expandtab" $USER_HOME/.vimrc && \
   grep -q "tabstop=2" $USER_HOME/.vimrc && \
   grep -q "shiftwidth=2" $USER_HOME/.vimrc && \
   grep -q "autoindent" $USER_HOME/.vimrc; then
  echo "PASS: .vimrc contains YAML-friendly settings"
  exit 0
else
  echo "FAIL: .vimrc should contain expandtab, tabstop=2, shiftwidth=2, and autoindent"
  exit 1
fi
