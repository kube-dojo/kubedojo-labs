# Memory Management Deep Dive

Linux memory management is sophisticated — it uses techniques like demand paging, page cache, and the OOM killer to maximize system performance and stability.

## What You Will Learn

- Reading memory statistics from `free`, `/proc/meminfo`, and `vmstat`
- Understanding the page cache and how Linux uses "free" memory
- How the OOM killer selects processes to terminate under memory pressure

## Prerequisites

- Basic understanding of RAM and virtual memory concepts
- Familiarity with the `/proc` filesystem
