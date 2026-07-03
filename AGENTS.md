# AGENTS.md - Codex Operating Rules

## Global Codex Operating Rules

- Start every task from the repository root and run `git status --short --branch`.
- Preserve user and unrelated changes; do not revert, delete, or clean up work you did not make.
- Use multi-agent delegation for non-trivial work that can run in parallel.
- Keep worker scopes disjoint, and explicitly tell agents not to revert or overwrite each other's changes.
- Use `apply_patch` for manual edits.
- Keep changes scoped to the requested task.
- Run relevant verification before finishing, or state clearly why verification was not run.
- Final reports must include changed files, verification performed, and final `git status --short --branch`.

## Project Context

Read `README.md` before making changes. Preserve active lab restructuring work and avoid touching unrelated prerequisite directories or generated solution files.
