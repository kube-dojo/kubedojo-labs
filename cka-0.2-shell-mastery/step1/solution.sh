#!/bin/bash
echo "alias k=kubectl" >> "$HOME"/.bashrc
echo "alias kgp='kubectl get pods'" >> "$HOME"/.bashrc
source "$HOME"/.bashrc
echo "Aliases added and sourced."
