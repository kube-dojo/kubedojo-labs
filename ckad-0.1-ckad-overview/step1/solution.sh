#!/bin/bash
cat > "$HOME"/.vimrc << 'VIMRC'
set tabstop=2
set shiftwidth=2
set expandtab
VIMRC

echo 'export KUBE_EDITOR=vim' >> "$HOME"/.bashrc
source "$HOME"/.bashrc

kubectl config current-context > "$HOME"/current-context.txt
