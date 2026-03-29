## Step 1: Generate SSH Keys

SSH (Secure Shell) uses **key pairs** for authentication -- a private key (kept secret) and a public key (shared with servers). This is more secure than passwords and is the standard for accessing cloud infrastructure.

### How key pairs work

1. You generate a pair: **private key** + **public key**
2. You put the public key on the server
3. When you connect, SSH proves you hold the matching private key
4. No password ever crosses the network

### Key types

- `rsa` -- older, widely compatible (use 4096 bits minimum)
- `ed25519` -- modern, faster, shorter keys, recommended

### Generate a key pair

Try generating a key with the default type:

```bash
ssh-keygen -t ed25519 -C "demo@kubedojo" -f /tmp/demo_key -N ""
```

- `-t ed25519` -- key type
- `-C "demo@kubedojo"` -- a comment (usually your email)
- `-f /tmp/demo_key` -- output file path
- `-N ""` -- empty passphrase (for this lab only; use passphrases in production)

Look at the results:

```bash
ls -la /tmp/demo_key*
```

You'll see two files: `demo_key` (private) and `demo_key.pub` (public).

```bash
cat /tmp/demo_key.pub
```

### Your task

Generate an ed25519 key pair at `/root/.ssh/lab_key` with no passphrase.

<details>
<summary>Hint</summary>

```bash
mkdir -p /root/.ssh
ssh-keygen -t ed25519 -f /root/.ssh/lab_key -N ""
```
</details>
