# Congratulations!

You have completed the Bash Scripting Fundamentals lab.

## What You Learned

- Variables, command substitution, and conditionals
- for and while loops for iteration
- Functions for modular, reusable code
- Error handling with `set -euo pipefail` and `trap`

## Key Takeaways

1. **Always use `set -euo pipefail`** in production scripts
2. **Always use `trap` for cleanup** — temp files, locks, child processes
3. **Quote your variables** — `"$VAR"` prevents word splitting bugs
4. **Use `[[ ]]`** instead of `[ ]` — it handles empty strings and patterns better

## Next Steps

- Explore `linux-7.2-text-processing` for awk, sed, and pipeline mastery
- Practice writing scripts for your daily tasks
