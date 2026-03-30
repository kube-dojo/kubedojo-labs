# Multiple Terminals with tmux

The CKA exam environment allows you to use tmux for multiple terminal panes. This is extremely useful for:

- Running `kubectl get pods -w` in one pane while working in another
- Keeping documentation open alongside your work
- Running long commands without blocking your main terminal

**Essential tmux commands:**
- `tmux new -s name` — create a named session
- `tmux ls` — list sessions
- `Ctrl+B %` — split vertically
- `Ctrl+B "` — split horizontally
- `Ctrl+B o` — switch panes
- `Ctrl+B d` — detach from session

## Task

Create a tmux session named `exam`.

You can detach from it afterward if needed (press `Ctrl+B` then `d`).

## Hint

Run `tmux new-session -d -s exam` to create the session in detached mode. Then verify with `tmux list-sessions`.
