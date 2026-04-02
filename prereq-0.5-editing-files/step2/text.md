## Step 2: Append Content to Files
### Your task
Append these two new lines to `~/configs/app.env`:
```
LOG_LEVEL=info
DEBUG=false
```
The file should end up with 6 lines total.
<details>
<summary>Hint</summary>
```bash
echo "LOG_LEVEL=info" >> ~/configs/app.env
echo "DEBUG=false" >> ~/configs/app.env
```
</details>