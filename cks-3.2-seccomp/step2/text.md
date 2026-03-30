# Create and Apply a Custom Seccomp Profile

Create a restrictive custom seccomp profile that only allows specific syscalls.

## Task

1. Create a custom seccomp profile at `/var/lib/kubelet/seccomp/profiles/nginx-strict.json`:
   ```json
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
   ```
2. Create a pod named `nginx-strict-seccomp` in `seccomp-lab` using this Localhost profile.
3. Verify the pod runs successfully and save its status to `/root/strict-pod-status.txt`.

## Hint

Use `securityContext.seccompProfile.type: Localhost` with `localhostProfile: profiles/nginx-strict.json`. The path is relative to `/var/lib/kubelet/seccomp/`.
