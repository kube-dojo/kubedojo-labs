## Step 1: Update and Search Packages

Before installing anything, you need to tell `apt` what packages are available. The package list is a local cache -- it doesn't update automatically.

### Update the package list

```bash
apt update
```

This downloads the latest list of available packages from Ubuntu's repositories. You should run this before installing anything.

### Search for packages

Looking for a web server? Search for it:

```bash
apt search nginx
```

This returns many results. To narrow it down:

```bash
apt search "^nginx$"
```

### Get package details

`apt show` gives you detailed information about a package -- version, size, description, and dependencies:

```bash
apt show nginx
```

This works for any package, installed or not.

### Your task

1. Run `apt update` to refresh the package list
2. Save the output of `apt show curl` to `/home/user/curl-info.txt`

<details>
<summary>Hint</summary>

```bash
apt update
apt show curl > /home/user/curl-info.txt
```

Note: `apt show` may output some warnings to stderr. To capture only the package info:

```bash
apt show curl 2>/dev/null > /home/user/curl-info.txt
```
</details>
