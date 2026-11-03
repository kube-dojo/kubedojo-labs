"""Manifest validation, reference evidence and CI selection. No lab code executes here."""
import argparse
import json
from pathlib import Path
import subprocess

REFERENCES = frozenset({
    "prereq-k8s-1.1-first-cluster", "prereq-k8s-1.2-kubectl",
    "prereq-k8s-1.3-pods", "prereq-k8s-1.4-deployments", "prereq-k8s-1.5-services",
    "prereq-0.3-first-commands", "prereq-0.4-files-directories",
    "prereq-0.5-editing-files", "prereq-0.7-servers-ssh", "prereq-0.8-packages",
})
CLASSES = {"change", "observe", "delete", "expect-error", "info"}
BACKENDS = {"ubuntu", "kubernetes-kubeadm-1node"}


def declared(root, value):
    if not isinstance(value, str) or not value or Path(value).is_absolute():
        raise ValueError(f"invalid declared path: {value!r}")
    path = root / value
    if not path.resolve().is_relative_to(root.resolve()) or not path.is_file():
        raise ValueError(f"missing or escaping declared path: {value}")
    return path


def steps_for(root):
    index = json.loads((root / "index.json").read_text())
    if not index.get("title") or index["backend"]["imageid"] not in BACKENDS:
        raise ValueError("missing title or unsupported backend")
    steps = index["details"]["steps"]
    if not isinstance(steps, list) or not steps:
        raise ValueError("steps must be a nonempty list")
    return index, steps


def step_files(root, step):
    # Evidence has a fixed name next to the declared text, never a sorted stepN guess.
    directory = declared(root, step["text"]).parent
    return directory / "learner.sh", directory / "requirements.yaml"


def requirements(root, step):
    _, path = step_files(root, step)
    # JSON is a strict YAML subset; no third-party parser executes on untrusted YAML.
    data = json.loads(path.read_text())
    rows = data["requirements"]
    if not isinstance(rows, list) or not rows:
        raise ValueError(f"checker adequacy not proven: {path}")
    ids, fixtures = set(), set()
    for row in rows:
        if not all(isinstance(row.get(k), str) and row[k].strip()
                   for k in ("id", "outcome", "assertion", "negative")):
            raise ValueError(f"incomplete requirement: {path}")
        if row["id"] in ids or row["negative"] in fixtures:
            raise ValueError(f"duplicate requirement or fixture: {path}")
        ids.add(row["id"])
        fixtures.add(row["negative"])
        negative = declared(path.parent, row["negative"])
        if not negative.is_relative_to(path.parent / "negative"):
            raise ValueError(f"fixture outside negative/: {negative}")
    if "initial_pass" in data and (not isinstance(data["initial_pass"], str)
                                    or not data["initial_pass"].strip()):
        raise ValueError(f"empty initial_pass reason: {path}")
    return data


def validate(root, reference=False):
    index, steps = steps_for(root)
    details = index["details"]
    # These are Killercoda's file-bearing manifest fields. Validate only declarations.
    for section in [details.get("intro", {}), *steps, details.get("finish", {})]:
        for key in ("text", "background", "foreground", "verify", "solution"):
            if key in section:
                declared(root, section[key])
    if not reference:
        return index, steps
    for step in steps:
        cls = step.get("class")
        if cls not in CLASSES:
            raise ValueError(f"missing class: {step.get('text')}")
        learner, _ = step_files(root, step)
        if cls == "info":
            if "verify" in step or learner.exists():
                raise ValueError(f"info step declares executable input: {step['text']}")
            continue
        if not learner.is_file():
            raise ValueError(f"not replayable: {learner}")
        if cls != "observe" and "verify" not in step:
            raise ValueError(f"missing class-required verify: {step['text']}")
        # A declared solution is authoritative. For older manifests only, the
        # author shortcut at the declared text directory is accepted, never hints.
        solution_path(root, step)
        if cls != "observe" or "verify" in step:
            requirements(root, step)
    return index, steps


def solution_path(root, step):
    value = step.get("solution", str(Path(step["text"]).parent / "solution.sh"))
    return declared(root, value)


def inventory(root):
    rows = []
    for path in sorted(root.glob("*/index.json")):
        if path.parent.name == "templates":
            continue
        row = {"scenario": path.parent.name,
               "level": "executable" if path.parent.name in REFERENCES else "residual"}
        try:
            index, steps = validate(path.parent, row["level"] == "executable")
            row.update(structural="pass", backend=index["backend"]["imageid"], steps=len(steps))
        except (ValueError, KeyError, TypeError, OSError) as exc:
            row.update(structural="fail", error=str(exc))
        if row["level"] == "residual":
            row.update(certification="not certified", replay="not replayable",
                       adequacy="checker adequacy not proven", execution="not run")
        rows.append(row)
    missing = REFERENCES - {r["scenario"] for r in rows}
    if missing:
        raise ValueError(f"missing references: {sorted(missing)}")
    return rows


def select(rows, changed=None):
    if changed is None or any(p.startswith(("scripts/", ".github/workflows/", "templates/"))
                              for p in changed):
        return [r["scenario"] for r in rows]
    return [r["scenario"] for r in rows
            if any(p == r["scenario"] or p.startswith(r["scenario"] + "/") for p in changed)]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument("--base")
    parser.add_argument("--report", type=Path, default=Path("reports/inventory.json"))
    parser.add_argument("--github-output", type=Path)
    args = parser.parse_args()
    rows = inventory(args.root)
    changed = None
    if args.base:
        changed = subprocess.check_output(
            ["git", "diff", "--name-only", f"{args.base}...HEAD"], cwd=args.root, text=True).splitlines()
    selected = select(rows, changed)
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps({"structural": rows, "selected": selected}, indent=2) + "\n")
    matrix = {"include": [{"scenario": r["scenario"], "backend": r.get("backend", "ubuntu"),
                            "touched": changed is not None and any(
                                p.startswith(r["scenario"] + "/") for p in changed)}
                          for r in sorted(rows, key=lambda row: (row["level"] != "executable", row["scenario"]))
                          if r["scenario"] in selected]}
    if args.github_output:
        with args.github_output.open("a") as output:
            output.write("matrix=" + json.dumps(matrix, separators=(",", ":")) + "\n")
            output.write(f"has_work={'true' if selected else 'false'}\n")
    print(json.dumps({"scenarios": len(rows), "steps": sum(r.get("steps", 0) for r in rows),
                      "references": sum(r["level"] == "executable" for r in rows),
                      "residual": sum(r["level"] == "residual" for r in rows),
                      "errors": [r for r in rows if r["structural"] == "fail"]}))
    return int(any(r["structural"] == "fail" for r in rows))


if __name__ == "__main__":
    raise SystemExit(main())
