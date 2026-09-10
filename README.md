# KubeDojo Labs

[![Test Lab Scenarios](https://github.com/kube-dojo/kubedojo-labs/actions/workflows/test-scenarios.yml/badge.svg?branch=main)](https://github.com/kube-dojo/kubedojo-labs/actions/workflows/test-scenarios.yml)

Interactive lab scenarios for [KubeDojo](https://kube-dojo.github.io/) — powered by [Killercoda](https://killercoda.com/).

## Structure

```
kubedojo-labs/
├── prerequisites/
│   ├── zero-to-terminal/     # Ubuntu labs for absolute beginners
│   └── kubernetes-basics/    # K8s cluster labs for K8s fundamentals
├── linux/
│   ├── everyday-use/         # CLI, processes, services
│   ├── system-essentials/    # Kernel, systemd, filesystem
│   └── networking/           # TCP/IP, DNS, iptables
├── k8s/
│   └── cka/
│       ├── part0/            # Environment & exam prep
│       ├── part1/            # Cluster architecture
│       ├── part2/            # Workloads & scheduling
│       ├── part3/            # Services & networking
│       ├── part4/            # Storage
│       └── part5/            # Troubleshooting
└── templates/
    ├── ubuntu-base/          # Base template for Linux labs
    └── k8s-base/             # Base template for K8s labs
```

## Scenario Format

Each lab is a directory containing:

```
lab-name/
├── index.json      # Metadata: title, environment, steps
├── intro.md        # Context + objectives
├── setup.sh        # Seeds environment before user starts
├── step1/
│   ├── text.md     # Instructions
│   └── verify.sh   # Validation (exit 0 = pass, exit 1 = fail)
├── step2/
│   ├── text.md
│   └── verify.sh
└── finish.md       # Congratulations + next lab link
```

## Environment Types

| Type | Killercoda Image | Use Case |
|------|-----------------|----------|
| Ubuntu | `ubuntu` | Linux basics, shell, networking |
| Kubernetes | `kubernetes-kubeadm-1node` | K8s labs (single control plane + worker) |

## Authoring Guidelines

1. **3-6 steps per lab** — focused, completable within time limit
2. **Each step = one concept** — don't overload
3. **verify.sh must be deterministic** — check exact state, not output format
4. **setup.sh must be idempotent** — safe to run multiple times
5. **No copy-paste answers** — steps require understanding
6. **Hints in collapsible sections**:
   ```markdown
   <details>
   <summary>Hint</summary>
   Try `kubectl get pods -n production`
   </details>
   ```

## Difficulty Calibration

| Level | Steps | Hints | Guidance |
|-------|:---:|---|---|
| Beginner | 3-4 | Generous, near-complete commands | High |
| Intermediate | 4-5 | Concept hints, not commands | Medium |
| Advanced | 5-6 | Minimal, doc references only | Low |

## Links

- **KubeDojo Site**: https://kube-dojo.github.io/
- **Killercoda Creators**: https://killercoda.com/creators
- **Project Plan**: See `docs/labs-project-plan.md` in the main repo
# Killercoda connected 2026-03-29T23:40:30Z
