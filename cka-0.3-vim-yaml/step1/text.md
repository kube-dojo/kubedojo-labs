# Vim Essentials

Vim has two main modes:
- **Normal mode** (default) — navigate and run commands
- **Insert mode** — type text (press `i` to enter, `Esc` to exit)

**Key commands:**
| Command | Action |
|---------|--------|
| `i` | Enter insert mode |
| `Esc` | Return to normal mode |
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `/pattern` | Search forward |
| `dd` | Delete current line |
| `yy` | Copy current line |
| `p` | Paste below |
| `u` | Undo |
| `gg` | Go to top of file |
| `G` | Go to bottom of file |

## Task

Create the file `/root/practice.yaml` using vim (or any method) with the following content:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test
```

The file must contain all four lines with correct YAML indentation.

## Hint

You can use `vim /root/practice.yaml`, press `i` to enter insert mode, type the content, press `Esc`, then type `:wq` to save and quit.
