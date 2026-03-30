## Step 1: Environment Variables

Environment variables are key-value pairs that configure how programs behave. Every process inherits them from its parent.

### Viewing variables

```bash
env                    # show all environment variables
echo $HOME             # show a specific variable
echo $PATH             # show the executable search path
```

### Setting variables

```bash
MY_VAR="hello"         # shell variable (not exported)
export MY_VAR="hello"  # environment variable (inherited by child processes)
```

### The PATH variable

`PATH` is a colon-separated list of directories where the shell looks for executables:

```bash
echo $PATH
```

You can add directories to it:

```bash
export PATH="/opt/myapp/bin:$PATH"
```

### Persisting variables

Variables set in the terminal are lost when you close it. Add them to `~/.bashrc` to make them permanent.

### Your task

1. Set the environment variable `MY_APP=/opt/myapp`
2. Add `/opt/myapp/bin` to your `PATH`
3. Persist both settings in `~/.bashrc`

<details>
<summary>Hint</summary>

Add export lines to `~/.bashrc`:

```bash
echo 'export MY_APP=/opt/myapp' >> ~/.bashrc
echo 'export PATH="/opt/myapp/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```
</details>
