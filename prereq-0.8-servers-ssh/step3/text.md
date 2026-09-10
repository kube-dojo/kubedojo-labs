# First Connection: Trust the Host, Check the Context

Time to connect. The shape is `ssh username@host`, plus two options from the module's table: `-p 2222` because the lab server listens on a non-default port, and `-i ~/.ssh/kd-lab-key` to present your specific key. On a first connection SSH asks whether to trust the host's fingerprint — that is the *client* verifying the *server*, separate from the server authenticating you. Accepting is reasonable here because the "remote" host is your own machine; on a production server you would verify the fingerprint from a trusted source first. The accepted key lands in `~/.ssh/known_hosts`.

## Task

1. Connect to the lab server as **your current user** at `localhost` port `2222` with your lab key, accepting the new host key, and run the context check remotely: capture `hostname`, `whoami`, and `pwd` from *inside the session* into `/tmp/kd-ssh/remote-context.txt`.
2. Compare with `/tmp/kd-ssh/local-context.txt` from step 1.

The verifier checks three live facts: your `known_hosts` entry matches the server's real host key, the server log recorded a real `Accepted publickey` login, and the captured context matches the machine.

<details>
<summary>Hint</summary>

```bash
ssh -o StrictHostKeyChecking=accept-new -p 2222 -i ~/.ssh/kd-lab-key "$(whoami)@localhost" \
  'hostname; whoami; pwd' > /tmp/kd-ssh/remote-context.txt
cat /tmp/kd-ssh/remote-context.txt
diff /tmp/kd-ssh/local-context.txt /tmp/kd-ssh/remote-context.txt || true
```

`accept-new` records the host key on first contact (that is the yes/no prompt, answered deliberately). The hostname matches your local snapshot — of course: `localhost` *is* this machine. The proof of remoteness is the authentication and the server log, not a different name. `pwd` may differ: a fresh SSH session starts in the account's home directory.

</details>
