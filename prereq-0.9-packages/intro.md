# Software and Packages

Downloading random files from websites makes every machine a slightly different snowflake. A package manager turns installation into repeatable commands you can review, copy, and update later — the same habit you will use for `kubectl`, `helm`, and every other cloud-native tool.

This lab accompanies [Module 0.9: Software and Packages](https://kube-dojo.github.io/prerequisites/zero-to-terminal/module-0.9-software-and-packages/). This machine runs Ubuntu, so you will practice with `apt`; the module shows how the same workflow translates to `brew`, `dnf`, and others.

## Objectives

- Refresh the package catalog with `apt update` and understand why installs fail without current metadata.
- Install `htop` and confirm the installed version.
- Install `tree` and use it to map a real directory structure.
- Inspect package metadata and dependencies with `apt show` and `apt-cache depends`.

This machine starts with a deliberately **stale package catalog** — exactly what a fresh server looks like. Work in order: later steps depend on earlier ones, just like real setup guides.
