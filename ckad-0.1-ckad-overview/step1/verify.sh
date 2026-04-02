#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Check .vimrc
if [ ! -f $USER_HOME/.vimrc ]; then
  echo "FAIL: $USER_HOME/.vimrc does not exist"
  exit 1
fi
if ! grep -q "tabstop=2" $USER_HOME/.vimrc; then
  echo "FAIL: $USER_HOME/.vimrc missing tabstop=2"
  exit 1
fi
if ! grep -q "expandtab" $USER_HOME/.vimrc; then
  echo "FAIL: $USER_HOME/.vimrc missing expandtab"
  exit 1
fi

# Check KUBE_EDITOR in bashrc
if ! grep -q "KUBE_EDITOR" $USER_HOME/.bashrc; then
  echo "FAIL: KUBE_EDITOR not set in $USER_HOME/.bashrc"
  exit 1
fi

# Check current-context.txt
if [ ! -f $USER_HOME/current-context.txt ]; then
  echo "FAIL: $USER_HOME/current-context.txt does not exist"
  exit 1
fi
CTX=$(cat $USER_HOME/current-context.txt | tr -d '[:space:]')
if [ -z "$CTX" ]; then
  echo "FAIL: $USER_HOME/current-context.txt is empty"
  exit 1
fi

echo "PASS: Exam environment configured"
exit 0
