# Vim for YAML

To make vim comfortable for YAML editing, configure these settings in `~/.vimrc`:

| Setting | Purpose |
|---------|---------|
| `set expandtab` | Convert tabs to spaces |
| `set tabstop=2` | Display tab width as 2 spaces |
| `set shiftwidth=2` | Indent by 2 spaces |
| `set autoindent` | Copy indent from current line to new line |
| `set paste` | Prevent auto-indent when pasting (toggle with `:set nopaste`) |

## Task

Create `/root/.vimrc` with YAML-friendly settings. Include at minimum:
- `expandtab`
- `tabstop=2`
- `shiftwidth=2`
- `autoindent`

## Hint

Create the file with `cat > /root/.vimrc` or use vim itself. Each setting goes on its own line preceded by `set`.
