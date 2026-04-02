## Step 3: Remove Packages
1. Remove the `wget` package using `apt remove`.
2. Check if `wget` is still in the system. Save the output of `which wget` to `~/wget-check.txt`.
<details>
<summary>Hint</summary>
```bash
sudo apt remove -y wget
which wget > ~/wget-check.txt
```
</details>