#!/bin/bash
cat > /root/.vimrc << 'VIMRC'
set tabstop=2
set shiftwidth=2
set expandtab
VIMRC

echo 'export KUBE_EDITOR=vim' >> /root/.bashrc
source /root/.bashrc

kubectl config current-context > /root/current-context.txt
