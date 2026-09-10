#!/bin/bash
# Points per minute: B=2.00, D=1.25, E=1.00, A=0.70, C=0.65
cat > "$HOME"/task-order.txt << 'EOF'
B
D
E
A
C
EOF
echo "Optimal task order (highest points-per-minute first):"
cat "$HOME"/task-order.txt
