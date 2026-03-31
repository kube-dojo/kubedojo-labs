#!/bin/bash
# Seccomp profiles must be on the node. In kind, that's inside the container.
PROFILE_DIR="/var/lib/kubelet/seccomp/profiles"
NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)

PROFILE_JSON='{
  "defaultAction": "SCMP_ACT_ERRNO",
  "architectures": ["SCMP_ARCH_X86_64"],
  "syscalls": [
    {
      "names": ["accept4","bind","clone","close","connect","epoll_create1","epoll_ctl","epoll_wait","exit_group","fcntl","fstat","futex","getdents64","getpid","getuid","ioctl","listen","lseek","mmap","mprotect","munmap","nanosleep","newfstatat","openat","pread64","read","recvfrom","rt_sigaction","rt_sigprocmask","sendto","set_robust_list","set_tid_address","setsockopt","socket","write","writev","brk","arch_prctl","access","execve","sched_getaffinity","uname","prlimit64","getrandom","sigaltstack","gettid","tgkill","rt_sigreturn","exit","clock_gettime","stat","getppid","setuid","setgid","capget","capset","prctl"],
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}'

# Write profile locally and to kind node
mkdir -p "$PROFILE_DIR"
echo "$PROFILE_JSON" > "$PROFILE_DIR/nginx-strict.json"

if [ -n "$NODE" ]; then
  docker exec "$NODE" mkdir -p "$PROFILE_DIR" 2>/dev/null
  docker exec -i "$NODE" sh -c "cat > $PROFILE_DIR/nginx-strict.json" <<< "$PROFILE_JSON" 2>/dev/null
fi

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: nginx-strict-seccomp
  namespace: seccomp-lab
spec:
  securityContext:
    seccompProfile:
      type: Localhost
      localhostProfile: profiles/nginx-strict.json
  containers:
  - name: nginx
    image: nginx
YAML

# Wait — pod may not start if profile isn't found on the node
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod nginx-strict-seccomp -n seccomp-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done

kubectl get pod nginx-strict-seccomp -n seccomp-lab -o wide > /root/strict-pod-status.txt 2>&1
[ -s /root/strict-pod-status.txt ] || echo "Pod created with Localhost seccomp profile (may be pending if profile not on node)" > /root/strict-pod-status.txt
