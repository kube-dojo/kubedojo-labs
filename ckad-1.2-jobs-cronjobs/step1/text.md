# Create and Configure Jobs

A Job creates one or more pods and ensures a specified number of them successfully terminate.

## Task

1. Create a Job named `countdown` in the `jobs-lab` namespace that runs `busybox:1.36` with command `sh -c "for i in 5 4 3 2 1; do echo $i; sleep 1; done; echo Done"`.
2. Wait for the Job to complete.
3. Save the logs from the Job's pod to `/root/countdown-logs.txt`.

## Hint

Use `kubectl create job countdown --image=busybox:1.36 -n jobs-lab -- sh -c "for i in 5 4 3 2 1; do echo \$i; sleep 1; done; echo Done"`.
