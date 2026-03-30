#!/bin/bash
cat > /root/.vimrc << 'EOF'
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
EOF
echo "Created /root/.vimrc:"
cat /root/.vimrc
