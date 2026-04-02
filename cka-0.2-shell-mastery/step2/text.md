# Output Filtering

Kubernetes commands produce a lot of output. Filtering it quickly is essential.

A sample JSON file has been created at `~/sample.json`.

## Task

Extract all names from the `items` array in `~/sample.json` and save them (one per line) to `~/names.txt`.

<details>
<summary>Hint</summary>

```bash
jq -r '.items[].name' ~/sample.json > ~/names.txt
```
</details>
