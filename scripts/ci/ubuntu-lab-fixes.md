# Ubuntu reference checker fixes

Each row records a checker change in this PR. The instructions decide the
required outcome. No Ubuntu reference solution, setup script, or lesson text
changes in this PR.

Controlled probes execute the original checker from `git show 18632b3:<path>` and
the modified checker against the same state. A before exit of 0 for an unmet
outcome is the defect. The corresponding learner and solution states return 0
after the repair. The reference harness replays each named fixture from its own
fresh environment after the earlier learner steps.

| Checker path | Defect and lesson instruction | Controlled before and after |
|---|---|---|
| `prereq-0.3-first-commands/step1/verify.sh` | A substring matched extra text. `step1/text.md:19` requires only the code. | `only-code.sh` writes `secret DOJO123 extra`. Before 0, after 1. A single `DOJO123` line, with or without a final newline, passes. |
| `prereq-0.3-first-commands/step3/verify.sh` | The checker accepted an extra running service other than nginx. `step3/text.md:6-7` requires the list of stopped services. | `stopped-list.sh` appends running redis to the complete stopped list. Before 0, after 1. The exact filtered list passes. |
| `prereq-0.4-files-directories/step1/verify.sh` | Destination existence accepted corrupt copies and copied rather than moved notes. `step1/text.md:13-15` requires copying report, moving notes, and renaming old_data.csv. | `report-copy.sh`, `notes-move.sh`, and `csv-rename.sh` each leave only their named operation unmet. Each returns before 0, after 1. The three correct operations pass. |
| `prereq-0.4-files-directories/step2/verify.sh` | Type-specific absence checks accepted a directory at the deleted file path or a file at the deleted directory path. `step2/text.md:6-7` requires both paths deleted. | `log-deleted.sh` and `directory-deleted.sh` preserve a target using the other type. Each returns before 0, after 1. Both absent paths pass. |
| `prereq-0.4-files-directories/step3/verify.sh` | Effective access checks do not establish owner permission bits, especially when the checker runs as root. `step3/text.md:6-7` requires owner execute and owner read. | Both owner-bit fixtures return after 1 and the correct bits return 0. Locally the checker runs as an ordinary user, so both original checks also reject these states. The root-specific before result requires CI. The replacement directly checks `stat` mode bits 0100 and 0400. |
| `prereq-0.4-files-directories/step4/verify.sh` | Existing backup filenames accepted corrupt contents. `step4/text.md:6` requires copying all archive and drafts .txt files. | `archive-txt.sh` and `draft-txt.sh` corrupt only the corresponding destination. Each returns before 0, after 1. Identical copies pass. |
| `prereq-0.5-editing-files/step3/verify.sh` | An extra `listn` typo remained acceptable once one `listen 80` line existed. The `sever_name` replacement was not required. `step3/text.md:3` requires both typo substitutions throughout the file. | `listen-typo.sh` retains another `listn` occurrence. Before 0, after 1. `server-typos.sh` is also rejected. Both completed substitutions pass. |
| `prereq-0.7-servers-ssh/step1/verify.sh` | Two arbitrary files passed as a key pair. `step1/text.md:2` requires a matching ed25519 key pair with no passphrase. | Real `ssh-keygen` creates mismatched ed25519 keys, an RSA pair, and an encrypted ed25519 pair in separate fixtures. Each returns before 0, after 1. A matching unencrypted ed25519 pair passes. Public-key comments are ignored. |
| `prereq-0.7-servers-ssh/step2/verify.sh` | A saved substring `:80` did not prove nginx was running or that the whole `ss -tlnp` output was saved. `step2/text.md:2-3` requires both. | `full-ports.sh` saves only port-80 rows. Before 0, after 1. `nginx-running.sh` stops nginx before saving the otherwise complete output and is rejected. Controlled process/output substitutes pass the complete running state. Real process and socket behavior requires CI. |
| `prereq-0.7-servers-ssh/step3/verify.sh` | A substring `22` accepted extra text or the wrong configured port. `step3/text.md:2` requires just the configured port number. | `port-only.sh` writes `port=22`. Before 0, after 1. The configured/default number on one logical line passes. The probe substitutes the configuration file path. |
| `prereq-0.7-servers-ssh/step4/verify.sh` | A checksum substring passed without the filename or full output. `step4/text.md:2` requires the complete `md5sum` output. | `full-checksum.sh` saves only the digest. Before 0, after 1. Real `md5sum` full output for the seeded file passes. |
| `prereq-0.8-packages/step1/verify.sh` | A `Package: curl` label did not establish populated package indexes or the full package description. `step1/text.md:2-3` requires apt update and saving apt show curl output. | `updated-lists.sh` removes package indexes before saving the remaining installed-package description. `full-curl-info.sh` saves only the package label after update. With controlled apt/index substitutes, each returns before 0, after 1. Full populated state passes. Real apt behavior requires CI. |
| `prereq-0.8-packages/step2/verify.sh` | A saved wget label passed even with no installed package or complete version output. `step2/text.md:2-3` requires installation and saving wget --version output. | `wget-installed.sh` saves the version and removes the package; `full-version.sh` installs the package but saves only a label. With controlled dpkg/wget substitutes, each returns before 0, after 1. Installed package plus full version passes. Real apt behavior requires CI. |
| `prereq-0.8-packages/step3/verify.sh` | Any failed which invocation passed, even exit 2, and installed-package state was not checked. `step3/text.md:2-3` requires removing wget and saving the absent command's output. | Controlled which exit 2 with an empty saved file returns before 0, after 1. Installed dpkg state with which exit 1 returns before 0, after 1. Absent package, which exit 1, and an empty existing output file return 0. Existing removal/output fixtures still reject unmet outcomes. |

Local validation covers all 17 Ubuntu step classes, transcripts, requirement
maps, and 36 negative fixtures. The ten learner/solution lane probes and 36
negative probes pass using temporary homes. The first-commands, files, and
editing scenarios use native filesystem commands. SSH cryptography and checksum
commands run for real. Process, socket, apt, dpkg, and package-command states use
controlled substitutes. Follow-up probes cover the process check and strict
package-removal exit handling. These results do not claim live Ubuntu 24.04,
systemd, networking, or package-manager execution; those checks require CI.

No `initial_pass` declarations are needed: each step has an unmet required
outcome immediately after setup and the earlier learner steps. In the delete
step, setup creates both `docs/drafts/tmp_file.log` and `to_delete_dir` before
the transcript removes them. All fixtures preserve the other outcomes of their
step. The package-removal transcript expects exit 1 for `which wget`, after an
exit-0 `apt remove` command.

## Exact-head review repairs

Review F2 found two over-strict checks introduced by the initial repair. The
following controlled probes compare head `7de2f81` with this revision using
identical temporary-home remapping. The socket probe substitutes process and
socket queries; the checksum probe uses real `md5sum` and file bytes.

| Path | Text requirement and defect | Controlled before and after |
|---|---|---|
| `prereq-0.7-servers-ssh/step2/verify.sh` | `step2/text.md:2-3` requires nginx running and a full saved `ss -tlnp` table. Byte equality rejected privileged process columns and historical PIDs. The checker now validates the table and required listener rows while accepting either privilege level and changed PIDs or unrelated sockets. | A complete privileged table with historical PIDs: before 1, after 0. Complete unprivileged table: before 0, after 0. Truncated port-only output: before 1, after 1. |
| `prereq-0.7-servers-ssh/step4/verify.sh` | `step4/text.md:2` requires full checksum output. Byte equality required one absolute filename spelling. The checker now validates one complete checksum record, the actual digest and the target filename, accepting relative spelling. | Real relative-path `md5sum`: before 1, after 0. Absolute-path output: before 0, after 0. Digest-only output: before 1, after 1. |

A subsequent controlled root probe also completed the owner-bit before/after
evidence for `prereq-0.4-files-directories/step3/verify.sh`: missing owner execute
with another execute bit set returned before 0, after 1; missing owner read with
another read bit set returned before 0, after 1; both required bits present
returned before 0, after 0. Both scripts used the same temporary-home remapping.
