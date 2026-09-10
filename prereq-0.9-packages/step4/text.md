# Read Package Metadata

Installing a tool is half the skill. The other half is reading what the package manager **knows**: version, source repository, description, and — most importantly — dependencies. This is the difference between "I ran a command" and "I can diagnose what the command changed."

Two commands, two views:

- `apt show <package>` — the full package record: version, origin, description, dependency list.
- `apt-cache depends <package>` — just the dependency relationships, useful when you want to explain why installing one package brought in several others.

## Task

1. Save the full package record for `htop` into `/tmp/kd-pkg/htop-metadata.txt`.
2. Save its dependency view into `/tmp/kd-pkg/htop-depends.txt`.
3. Read both files and find one dependency — that library is part of what makes `htop` run; it is not suspicious extra baggage.

<details>
<summary>Hint</summary>

```bash
apt show htop > /tmp/kd-pkg/htop-metadata.txt
apt-cache depends htop > /tmp/kd-pkg/htop-depends.txt
cat /tmp/kd-pkg/htop-metadata.txt
cat /tmp/kd-pkg/htop-depends.txt
```

Look for the `Depends:` lines — on Ubuntu, `htop` typically depends on terminal and system libraries such as `libncursesw6`.

</details>
