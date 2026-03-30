# Timed Practice

Speed matters in the CKA exam. You need to be comfortable writing quick bash scripts and working fast under pressure.

## Task

Write a bash script at `/root/create-files.sh` that:

1. Creates a directory `/root/timed/`
2. Creates 5 files named `test-1.txt` through `test-5.txt` inside it
3. Each file should contain the text "file N" where N is the file number

Make the script executable and run it.

## Hint

Use a for loop: `for i in $(seq 1 5); do ... done`. Remember to `mkdir -p` before creating files, and `chmod +x` to make it executable.
