## Step 2: Check Listening Ports
1. Make sure nginx is running (start it if it isn't).
2. Save the full output of `ss -tlnp` to `~/ports.txt`.
<details>
<summary>Hint</summary>
```bash
sudo service nginx start
ss -tlnp > ~/ports.txt
```
</details>