# Time Management

The three-pass strategy maximizes your score:

1. **Pass 1** (quick wins): Tasks taking 1-3 minutes. Do these first.
2. **Pass 2** (medium): Tasks taking 4-6 minutes.
3. **Pass 3** (complex): Tasks taking 7+ minutes with remaining time.

The key metric is **points per minute** — tackle high-efficiency tasks first.

A file `~/exam-tasks.txt` has been created with 5 mock tasks, each showing points and estimated time.

## Task

Read `~/exam-tasks.txt`, calculate the points-per-minute for each task, and save the optimal order (highest efficiency first) to `~/task-order.txt`.

Write one task letter per line (e.g., `B`, `D`, `E`, `A`, `C`).

<details>
<summary>Hint</summary>

Calculate: Task A = 7/10 = 0.70, Task B = 4/2 = 2.00, Task C = 13/20 = 0.65, Task D = 5/4 = 1.25, Task E = 8/8 = 1.00.
```bash
cat <<'EOF' > ~/task-order.txt
B
D
E
A
C
EOF
```
</details>