#!/bin/bash
mkdir -p /var/lib/kubelet/seccomp/profiles
cat > /var/lib/kubelet/seccomp/profiles/nginx-strict.json << 'JSON'
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "architectures": ["SCMP_ARCH_X86_64"],
  "syscalls": [
    {
      "names": ["accept4","bind","clone","close","connect","epoll_create1","epoll_ctl","epoll_wait","exit_group","fcntl","fstat","futex","getdents64","getpid","getuid","ioctl","listen","lseek","mmap","mprotect","munmap","nanosleep","newfstatat","openat","pread64","read","recvfrom","rt_sigaction","rt_sigprocmask","sendto","set_robust_list","set_tid_address","setsockopt","socket","write","writev","brk","arch_prctl","access","execve","sched_getaffinity","uname","prlimit64","getrandom","sigaltstack","gettid","tgkill","rt_sigreturn","exit","clock_gettime","stat","getppid","setuid","setgid","capget","capset","prctl"],
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}
JSON

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
kubectl wait --for=condition=Ready pod/nginx-strict-seccomp -n seccomp-lab --timeout=60s 2>&1 || true
kubectl get pod nginx-strict-seccomp -n seccomp-lab -o wide > /root/strict-pod-status.txt
