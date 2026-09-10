# Refresh the Package Catalog

`apt` can only install what its **local catalog** knows about — and this machine's catalog is empty, like a brand-new server. Try asking apt about `htop` right now:

```bash
apt-cache policy htop
```

Empty output (or no candidate version) means apt has never downloaded the package index from its repositories. This is why beginners see `E: Unable to locate package ...` on fresh machines.

`apt update` does **not** upgrade or install anything. It downloads the latest package index so later commands work from current information. It changes system files, so it needs `sudo` — when the password prompt shows nothing while you type, that is deliberate; type it and press Enter.

## Task

Refresh the package catalog, then confirm `apt-cache policy htop` now shows a **Candidate** version.

<details>
<summary>Hint</summary>

```bash
sudo apt update
apt-cache policy htop
```

The second command should now show a `Candidate:` line with a version number — proof the catalog knows where to get `htop`.

</details>
