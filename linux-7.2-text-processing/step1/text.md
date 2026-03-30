# awk — Field Processing

`awk` processes text line by line, splitting each line into fields.

## Basics

```bash
# Print specific columns (space-delimited)
awk '{print $1, $3}' file.txt

# CSV: set field separator
awk -F',' '{print $1, $3}' data.csv

# Conditions
awk -F',' '$3 > 90000 {print $1, $3}' data.csv

# Built-in variables
# NR = line number, NF = number of fields, $NF = last field
awk -F',' 'NR > 1 {print NR, $1}' data.csv
```

## Arithmetic

```bash
# Sum a column
awk -F',' 'NR > 1 {sum += $3} END {print sum}' data.csv

# Average
awk -F',' 'NR > 1 {sum += $3; n++} END {print sum/n}' data.csv
```

## Your Task

Using `/root/data.csv`, calculate the **total salary** of all employees and save it to `/root/awk-sum.txt`.

The file should contain just the number (e.g., `845000`).

**Hint:**
```bash
awk -F',' 'NR > 1 {sum += $3} END {print sum}' /root/data.csv > /root/awk-sum.txt
```
