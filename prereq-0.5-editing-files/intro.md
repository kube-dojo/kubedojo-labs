## Editing Files

In the previous labs you created simple files with `echo` and a single redirect. Real-world configs have multiple lines, need updates over time, and sometimes contain mistakes you need to fix in bulk.

This lab teaches you three essential skills: creating multi-line files, appending content without overwriting, and performing search-and-replace operations.

### What You'll Learn

- Create multi-line files with `echo -e`, heredocs (`cat << EOF`), and redirections
- Append content to existing files with `>>`
- Find and fix text in files with `sed -i`

### Before You Start

If you haven't read the theory yet, check out [Module 0.5: Editing Files](https://kube-dojo.github.io/prerequisites/zero-to-terminal/module-0.5-editing-files/) on KubeDojo.

This lab takes about **20 minutes**. Type the commands yourself -- muscle memory is the goal.

Let's go!
