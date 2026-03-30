## Step 1: Command History and Shortcuts

Every command you type is saved in your history. Learning to reuse past commands saves enormous amounts of time.

### View your history

```bash
history
```

The list might be short right now, but it grows with every command you run.

### Key shortcuts

- `!!` — re-run the last command
- `!$` — reuse the last argument from the previous command
- `Ctrl+R` — search backward through history (press again to cycle matches)
- `Ctrl+A` / `Ctrl+E` — jump to start / end of line
- `Ctrl+W` — delete the word before the cursor

Try running a few commands, then use `!!` to repeat the last one:

```bash
echo "Hello from KubeDojo"
!!
```

### Aliases

Aliases let you create shortcuts for frequently used commands:

```bash
alias ll='ls -la'
ll
```

The alias works immediately, but it disappears when you close the terminal. To make it permanent, add it to `~/.bashrc`.

### Your task

1. Create the alias `ll='ls -la'`
2. Add it to `~/.bashrc` so it persists across sessions
3. Verify the alias works by running `ll`

<details>
<summary>Hint</summary>

Add the alias line to the end of `~/.bashrc`:

```bash
echo "alias ll='ls -la'" >> ~/.bashrc
```

Then source it and test:

```bash
source ~/.bashrc
ll
```
</details>
