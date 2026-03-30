# Timed Challenge — Create Resources Under Pressure

In the real exam, you will need to create multiple resources quickly. This step simulates that pressure.

## Task

Complete all of the following in under 5 minutes:

1. Create a namespace `exam-sim`.
2. Create a pod `task1` with image `redis:7` in `exam-sim`.
3. Create a deployment `task2` with image `nginx:1.25` and 2 replicas in `exam-sim`.
4. Create a ConfigMap `task3` with key `ENV=production` in `exam-sim`.
5. Create a service `task4` of type ClusterIP that exposes deployment `task2` on port 80 in `exam-sim`.
6. Save the ClusterIP of service `task4` to `/root/task4-ip.txt`.

## Hint

Use `kubectl expose deployment task2 --name=task4 --port=80 -n exam-sim` for the service. Use `kubectl get svc task4 -n exam-sim -o jsonpath='{.spec.clusterIP}'` to get the IP.
