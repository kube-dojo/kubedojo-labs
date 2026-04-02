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

```bash
alias k=kubectl
alias kgp='kubectl get pods'
```

Then source the file so the aliases take effect.

<details>
<summary>Hint</summary>

```bash
echo "alias k=kubectl" >> ~/.bashrc
echo "alias kgp='kubectl get pods'" >> ~/.bashrc
source ~/.bashrc
```
</details>
