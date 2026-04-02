## Step 3: Fast Edits with sed
### Your task
Fix typos in `~/configs/nginx.conf`: change `sever` to `server` and `listn` to `listen`.
<details>
<summary>Hint</summary>
```bash
sed -i 's/sever/server/g' ~/configs/nginx.conf
sed -i 's/listn/listen/g' ~/configs/nginx.conf
```
</details>