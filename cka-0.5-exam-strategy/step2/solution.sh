#!/bin/bash
# Points per minute: B=2.00, D=1.25, E=1.00, A=0.70, C=0.65
cat > /root/task-order.txt << 'EOF'
B (4pts/2min = 2.00 pts/min)
D (5pts/4min = 1.25 pts/min)
E (8pts/8min = 1.00 pts/min)
A (7pts/10min = 0.70 pts/min)
C (13pts/20min = 0.65 pts/min)
EOF
echo "Optimal task order:"
cat /root/task-order.txt
