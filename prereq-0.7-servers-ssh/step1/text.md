## Step 1: Generate SSH Keys
Generate an ed25519 key pair at `~/.ssh/lab_key` with no passphrase.
<details>
<summary>Hint</summary>
```bash
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -f ~/.ssh/lab_key -N ""
```
</details>