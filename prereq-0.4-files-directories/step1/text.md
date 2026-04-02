## Step 1: Copy and Move Files

The `cp` command copies files, and `mv` moves (or renames) them. Let's practice both.

### Explore the workspace
```bash
cd ~/lab-workspace
find . -type f
```

### Your task
Make sure you have:
1. `report.txt` copied from `docs/drafts/` into the `backup/` directory.
2. `notes.txt` moved from `docs/drafts/` to `docs/archive/`.
3. `old_data.csv` renamed to `historical_data.csv` inside `docs/archive/`.

<details>
<summary>Hint</summary>

```bash
cd ~/lab-workspace
cp docs/drafts/report.txt backup/
mv docs/drafts/notes.txt docs/archive/
mv docs/archive/old_data.csv docs/archive/historical_data.csv
```
</details>
