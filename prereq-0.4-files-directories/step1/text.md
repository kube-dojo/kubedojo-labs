## Step 1: Copy and Move Files

The `cp` command copies files, and `mv` moves (or renames) them. Let's practice both.

### Explore the workspace

First, see what's in the lab workspace:

```bash
cd /home/user/lab-workspace
find . -type f
```

You should see files spread across `docs/drafts/`, `docs/archive/`, and more.

### Copy a file

Copy `report.txt` from `docs/drafts/` into the `backup/` directory:

```bash
cp docs/drafts/report.txt backup/
```

Verify the copy:

```bash
ls backup/
cat backup/report.txt
```

The original is still in `docs/drafts/` -- `cp` creates a duplicate.

### Move a file

Move `notes.txt` from `docs/drafts/` to `docs/archive/`:

```bash
mv docs/drafts/notes.txt docs/archive/
```

Verify:

```bash
ls docs/drafts/
ls docs/archive/
```

Notice that `notes.txt` is **gone** from `drafts/` -- `mv` removes the original.

### Rename a file

Renaming is just `mv` with a new name in the same directory. Rename `old_data.csv` to `historical_data.csv`:

```bash
mv docs/archive/old_data.csv docs/archive/historical_data.csv
```

Verify:

```bash
ls docs/archive/
```

### Your task

Make sure you have:
1. `report.txt` copied into `backup/`
2. `notes.txt` moved to `docs/archive/`
3. `old_data.csv` renamed to `historical_data.csv`

<details>
<summary>Hint</summary>

```bash
cp docs/drafts/report.txt backup/
mv docs/drafts/notes.txt docs/archive/
mv docs/archive/old_data.csv docs/archive/historical_data.csv
```
</details>
