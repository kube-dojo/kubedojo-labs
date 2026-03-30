# Explore the Exam Environment and kubectl Shortcuts

In the CKAD exam you have access to kubectl, a terminal, and the Kubernetes docs. Setting up aliases and autocompletion first saves time on every subsequent task.

## Task

1. Verify kubectl autocompletion is enabled by typing `kubectl ` then pressing Tab — it should show subcommands.
2. Create the file `/root/.vimrc` with the following content to make YAML editing easier:
   ```
   set tabstop=2
   set shiftwidth=2
   set expandtab
   ```
3. Set the environment variable `KUBE_EDITOR=vim` and export it by adding it to `/root/.bashrc`.
4. Verify your setup by saving the output of `kubectl config current-context` to `/root/current-context.txt`.

## Hint

Use `echo 'export KUBE_EDITOR=vim' >> /root/.bashrc` to persist the editor setting.
