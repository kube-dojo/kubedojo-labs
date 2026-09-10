# Work Through the Session, Then Disconnect

A session is a lifecycle: connect, verify, **work**, disconnect. During the working middle, every command you type runs on the server end of the connection — same spelling, different target. And ending matters: a clean `exit` closes the remote shell and hands control back to your local terminal. The server logs both ends of the lifecycle, which is exactly the evidence an operator (or an auditor) reads later.

## Task

1. Open a session to the lab server again and, *through it*, write the line `Hello from SSH!` into `/tmp/kd-ssh/hello.txt`, then let the session end cleanly.
2. Back at your local shell, prove you have returned: record `hostname` into `/tmp/kd-ssh/after-exit.txt`.

The verifier reads the server's own log at `/var/log/kd-sshd.log`: it must show at least two accepted logins (step 3 and this one) and clean disconnects — writing `hello.txt` locally without a real session fails.

<details>
<summary>Hint</summary>

```bash
ssh -p 2222 -i ~/.ssh/kd-lab-key "$(whoami)@localhost" \
  'echo "Hello from SSH!" > /tmp/kd-ssh/hello.txt; exit'
hostname > /tmp/kd-ssh/after-exit.txt
grep -E "Accepted publickey|Disconnected from user" /var/log/kd-sshd.log
```

In an interactive session you would type the commands, then `exit` (or `Ctrl+D`) to disconnect. Here the command string plays the working middle, and the connection closing is your clean disconnect — read the log lines: one `Accepted publickey` and one `Disconnected from user` per session, your lifecycle in the server's own words.

</details>
