# Timed Practice

Speed matters in the CKA exam. You need to be comfortable writing quick bash scripts.

## Task

Write a bash script at `~/create-files.sh` that:
1. Creates a directory `~/timed/`
2. Creates 5 files named `test-1.txt` through `test-5.txt` inside it
3. Each file should contain the text "file N" where N is the file number

Make the script executable and run it.

<details>
<summary>Hint</summary>

```bash
cat << 'INNEREOF' > ~/create-files.sh
#!/bin/bash
mkdir -p ~/timed
for i in {1..5}; do
  echo "file $i" > ~/timed/test-$i.txt
done
INNEREOF
chmod +x ~/create-files.sh
~/create-files.sh
```
</details>
