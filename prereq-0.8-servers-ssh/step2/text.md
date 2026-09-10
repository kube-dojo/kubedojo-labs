# Create and Authorize an SSH Key Pair

SSH keys beat passwords for server work: nothing reusable travels to the server, and access can be granted or revoked per key. You keep the **private key** (the key); the server stores the matching **public key** (the lock) in that account's `~/.ssh/authorized_keys`. During login the server verifies you *possess* the private key without ever receiving it.

This lab uses a dedicated key file, `~/.ssh/kd-lab-key`, so nothing touches any default key you may already have — and it forces you to practice pointing SSH at a specific key, exactly what the `-i` option is for.

## Task

1. Generate an Ed25519 key pair with no passphrase at `~/.ssh/kd-lab-key`, with comment `kd-lab`.
2. Append the public key to `~/.ssh/authorized_keys`.
3. Tighten permissions: `~/.ssh` must be `700`, `authorized_keys` `600` (the server refuses sloppy permissions).

The verifier checks the pair actually matches (public key re-derived from the private one) and that the lab SSH server is listening on port `2222`.

<details>
<summary>Hint</summary>

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
ssh-keygen -t ed25519 -N "" -C kd-lab -f ~/.ssh/kd-lab-key
cat ~/.ssh/kd-lab-key.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
ls -l ~/.ssh/kd-lab-key ~/.ssh/kd-lab-key.pub
```

`kd-lab-key` is the private half — never share it. `kd-lab-key.pub` is the public half — this is the only part that belongs on servers (or GitHub).

</details>
