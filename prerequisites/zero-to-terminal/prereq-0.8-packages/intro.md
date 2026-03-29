## Software and Packages

Every Linux system needs software installed, updated, and managed. On Ubuntu and Debian systems, the `apt` package manager handles this. In Kubernetes environments, you'll use `apt` to install tools like `kubectl`, `helm`, `curl`, and debugging utilities on nodes.

This lab teaches you how to find, install, and inspect packages -- skills you'll use every time you set up a new server or troubleshoot a Kubernetes node.

### What You'll Learn

- Update package lists with `apt update`
- Search for and inspect packages with `apt search` and `apt show`
- Install packages with `apt install`
- Inspect installed packages with `dpkg`, `which`, and `whereis`

### Before You Start

If you haven't read the theory yet, check out [Module 0.8: Software and Packages](https://kube-dojo.github.io/prerequisites/zero-to-terminal/module-0.8-packages/) on KubeDojo.

This lab takes about **20 minutes**. Type the commands yourself -- muscle memory is the goal.

Let's go!
