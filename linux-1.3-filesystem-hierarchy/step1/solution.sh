#!/bin/bash
# Solution: Create FHS quiz file
cat > "$HOME"/fhs-quiz.txt << 'EOF'
/etc=system configuration files
/var=variable data like logs and databases
/tmp=temporary files cleared on reboot
/home=user home directories
/usr=user programs and libraries
/opt=optional third-party software
EOF
cat "$HOME"/fhs-quiz.txt
