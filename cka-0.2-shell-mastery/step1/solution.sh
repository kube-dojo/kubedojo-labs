#!/bin/bash
echo "alias k=kubectl" >> /root/.bashrc
echo "alias kgp='kubectl get pods'" >> /root/.bashrc
source /root/.bashrc
echo "Aliases added and sourced."
