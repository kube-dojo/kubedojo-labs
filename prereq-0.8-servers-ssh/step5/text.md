# Build the Remote Command Without Running It

Real servers differ from this lab only in the values: a public address, a username chosen by the image vendor, maybe a non-default port and a specific key. The module's option table covers it — `-p` for the port, `-i` for the key file, `user@host` for the target. A careful operator can *construct* the exact command before running it, and reads every piece (user, host, port, key) as separate facts before pressing Enter.

## Task

Write — do not run — the command that would connect as user `admin` to host `10.0.0.5` on port `2222` using the key file `~/.ssh/work_key`. Save the single command line into `/tmp/kd-ssh/constructed-command.txt`.

The verifier parses your command: correct program, port, key file, and target, in any option order.

<details>
<summary>Hint</summary>

```bash
echo 'ssh -p 2222 -i ~/.ssh/work_key admin@10.0.0.5' > /tmp/kd-ssh/constructed-command.txt
cat /tmp/kd-ssh/constructed-command.txt
```

Read it back the way you would before a production login: program `ssh`, port `2222` (non-default, so `-p` is required), identity file `~/.ssh/work_key` (the private half, presented not sent), account `admin`, host `10.0.0.5`. Five separate facts — verify each one, then connect.

</details>
