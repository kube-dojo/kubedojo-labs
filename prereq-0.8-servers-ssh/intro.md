# Servers and SSH: Context, Keys, Session Lifecycle

A server is a computer doing a job for other computers, and SSH is the secure phone line you use to operate it from a terminal. The commands you already know keep their spelling after login — what changes is *where they run*. This lab makes that difference concrete the safest possible way: by connecting to an SSH server running on your own machine.

This lab accompanies [Module 0.8: Servers and SSH](https://kube-dojo.github.io/prerequisites/zero-to-terminal/module-0.8-servers-and-ssh/) and practices its core habit: **connect, verify context, work, disconnect** — prove the target before you act.

## Objectives

- Record local context evidence (`hostname`, `whoami`, `pwd`) before any SSH connection.
- Generate an Ed25519 key pair and authorize the public key — the key stays private, the lock goes on the server.
- Make a first connection to a real SSH server on `localhost` port `2222`, accepting the host key deliberately, and capture the remote context.
- Run commands through the session and disconnect cleanly — the server's own log is your evidence.
- Build (but do not run) the command that would reach a real remote server with a non-default port and a specific key file.

The setup started a dedicated lab SSH server on port `2222` logging to `/var/log/kd-sshd.log`. Evidence goes to `/tmp/kd-ssh/`; the verifier cross-checks it against the live system — the real hostname, the real host key, the real server log — so forged notes without real connections fail.
