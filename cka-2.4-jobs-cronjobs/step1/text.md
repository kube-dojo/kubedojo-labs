## Job — Run to Completion

A Job creates one or more pods and ensures they run to successful completion.

### Task

Create a Job named `pi-job` in the `practice` namespace that computes pi to 2000 digits:

- Image: `perl:5.34`
- Command: `perl -Mbignum=bpi -wle 'print bpi(2000)'`
- Restart policy: `Never`

Wait for the Job to complete and check the output:

```bash
kubectl wait --for=condition=Complete job/pi-job -n practice --timeout=120s
kubectl logs job/pi-job -n practice
```

<details>
<summary>Hint: Job YAML structure</summary>

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pi-job
  namespace: practice
spec:
  template:
    spec:
      containers:
      - name: pi
        image: perl:5.34
        command: ["perl", "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
```

You can also create a Job imperatively: `kubectl create job pi-job --image=perl:5.34 -n practice -- perl -Mbignum=bpi -wle 'print bpi(2000)'`
</details>
