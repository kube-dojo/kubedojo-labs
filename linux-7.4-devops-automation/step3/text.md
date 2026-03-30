# CI/CD Pipeline Simulation

A CI/CD pipeline typically has stages: **build**, **test**, and **deploy**. Let's simulate this in bash.

## Pipeline Design

```
build() -> test() -> deploy()
   |          |          |
   v          v          v
 compile    run tests  ship it
```

Each stage should:
- Print what it's doing
- Simulate work (brief sleep)
- Return success/failure
- Stop the pipeline on failure

## Your Task

Write `/root/pipeline.sh` that:

1. Defines three functions: `build()`, `test()`, and `deploy()`
2. Each function prints a banner, simulates work, and reports success
3. The pipeline runs all three stages in order
4. If any stage fails, the pipeline stops immediately

Expected output:
```
=== BUILD STAGE ===
Compiling application...
Build successful.

=== TEST STAGE ===
Running unit tests...
All tests passed.

=== DEPLOY STAGE ===
Deploying to production...
Deployment successful.

Pipeline completed successfully!
```

Make it executable and run it.
