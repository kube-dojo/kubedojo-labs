#!/bin/bash
cat > "$HOME"/.vimrc << 'EOF'
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
EOF
echo "Created $HOME/.vimrc:"
cat "$HOME"/.vimrc
