# Install tree and Map a Directory

`tree` turns nested folders into a readable outline — perfect for explaining a project layout or checking that files ended up where you expected.

Your home directory contains `~/kubedojo-practice`, the recipe structure from the earlier file-system module. You will install `tree` and use it to map that structure.

## Task

1. Install `tree` with apt (the catalog is already fresh from step 1).
2. Run `tree` against `~/kubedojo-practice` and save the outline into `/tmp/kd-pkg/tree-output.txt`.
3. Look at the saved output: each branch is a directory or file — can you spot all three recipes?

<details>
<summary>Hint</summary>

```bash
sudo apt install -y tree
tree ~/kubedojo-practice > /tmp/kd-pkg/tree-output.txt
cat /tmp/kd-pkg/tree-output.txt
```

If you ever see "No such file or directory", that is a file-system problem, not a package problem — test `tree` against another directory before blaming the install.

</details>
