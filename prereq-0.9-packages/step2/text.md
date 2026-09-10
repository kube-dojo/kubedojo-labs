# Install and Check htop

`htop` is a live terminal view of CPU, memory, and running processes — a small, safe first install that follows the exact pattern you will later use for bigger tools.

Installation writes into system directories like `/usr/bin`, so it needs `sudo`. When apt shows its plan (the package plus any dependencies), read it before confirming with `y` — that pause is a professional habit, not busywork.

## Task

1. Install `htop` with apt.
2. Start it (`htop`), look around, and press `q` to quit — interactive terminal programs use keys, not close buttons.
3. Record the installed version into `/tmp/kd-pkg/htop-version.txt`. Version output is the first fact engineers compare when two machines behave differently.

<details>
<summary>Hint</summary>

```bash
sudo apt install -y htop
htop --version > /tmp/kd-pkg/htop-version.txt
cat /tmp/kd-pkg/htop-version.txt
```

The `-y` flag auto-confirms the plan — fine in a lab, but on important machines leave it off and read what apt proposes.

</details>
