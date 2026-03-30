# Bash Shortcuts for Speed

In the CKA exam, typing `kubectl` hundreds of times wastes precious seconds. Aliases are your best friend.

**Essential keyboard shortcuts:**
- `Ctrl+A` — jump to beginning of line
- `Ctrl+E` — jump to end of line
- `Ctrl+W` — delete word before cursor
- `Ctrl+R` — reverse search history
- `!!` — repeat last command
- `!$` — last argument of previous command

## Task

Add the following aliases to your `~/.bashrc`:

```
alias k=kubectl
alias kgp='kubectl get pods'
```

Then source the file so the aliases take effect.

## Hint

Use `echo` to append lines to `~/.bashrc`, then run `source ~/.bashrc`. In the real exam, these aliases are often pre-configured, but knowing how to set them up is important.
