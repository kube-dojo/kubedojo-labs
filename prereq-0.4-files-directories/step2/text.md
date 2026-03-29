## Step 2: Delete Files and Directories

The `rm` command removes files permanently -- there is no trash can in the terminal. Be careful!

### Delete a single file

Remove the temporary log file from `docs/drafts/`:

```bash
cd /home/user/lab-workspace
rm docs/drafts/tmp_file.log
```

Verify it's gone:

```bash
ls docs/drafts/
```

### Delete a directory

Try to remove the `to_delete_dir/` directory with plain `rm`:

```bash
rm to_delete_dir
```

You'll get an error: `rm: cannot remove 'to_delete_dir': Is a directory`. Directories need the `-r` (recursive) flag:

```bash
rm -r to_delete_dir
```

Verify:

```bash
ls /home/user/lab-workspace/
```

The `to_delete_dir/` directory and everything inside it is gone.

### Important safety tip

Never run `rm -rf /` or `rm -rf ~` -- these can destroy your entire system. In real life, double-check your path before pressing Enter.

### Your task

Make sure you have:
1. Deleted `tmp_file.log` from `docs/drafts/`
2. Deleted the entire `to_delete_dir/` directory

<details>
<summary>Hint</summary>

```bash
rm /home/user/lab-workspace/docs/drafts/tmp_file.log
rm -r /home/user/lab-workspace/to_delete_dir
```
</details>
