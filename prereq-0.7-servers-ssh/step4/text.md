## Step 4: Verify File Integrity

When you download files, transfer backups, or receive configs, you need to verify they haven't been corrupted or tampered with. **Checksums** solve this.

### How checksums work

A checksum is a fixed-length string computed from a file's contents. If even one byte changes, the checksum changes completely. Common tools:

| Command | Algorithm | Output length |
|---------|-----------|---------------|
| `md5sum` | MD5 | 32 hex chars |
| `sha256sum` | SHA-256 | 64 hex chars |

### Try it

```bash
echo "hello" > /tmp/test.txt
md5sum /tmp/test.txt
```

Now change the file slightly and compare:

```bash
echo "Hello" > /tmp/test.txt
md5sum /tmp/test.txt
```

The checksum is completely different, even though only one character changed.

### Your task

The setup script created `/home/user/important-data.bin`. Compute its MD5 checksum and save the **full output** of `md5sum` to `/home/user/checksum.txt`.

```bash
cat /home/user/important-data.bin
```

<details>
<summary>Hint</summary>

```bash
md5sum /home/user/important-data.bin > /home/user/checksum.txt
```

You can verify the checksum later with:

```bash
md5sum -c /home/user/checksum.txt
```
</details>
