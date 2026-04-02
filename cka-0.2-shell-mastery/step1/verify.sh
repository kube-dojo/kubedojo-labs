#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Check if aliases are present in .bashrc and properly formatted
if ! grep -qE "^alias k=['\"]?kubectl['\"]?$" $USER_HOME/.bashrc; then
  echo "FAIL: alias k=kubectl not found in ~/.bashrc"
  exit 1
fi

if ! grep -qE "^alias kgp=['\"]?kubectl get pods['\"]?$" $USER_HOME/.bashrc; then
  echo "FAIL: alias kgp='kubectl get pods' not found in ~/.bashrc"
  exit 1
fi

echo "PASS: Aliases found in ~/.bashrc"
exit 0
