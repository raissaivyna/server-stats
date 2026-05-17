# Server Stats

A shell script to analyze basic Linux server performance statistics.

## What it shows

- Total CPU usage
- Total memory usage (free vs. used + percentage)
- Disk utilization (free vs. used + percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage
- OS version, kernel, uptime and load average
- Connected users
- Failed login attempts

## Requirements

- Linux (any distribution)
- Bash
- Tools: `top`, `free`, `df`, `ps`, `who`, `lastb`, `nproc`, `bc`

## How to run

```bash
chmod +x server-stats.sh
./server-stats.sh
```

## Example output

```
==============================
   SERVER PERFORMANCE STATS   
==============================
Data: sáb 16 mai 2026 19:21:08 -03

[ CPU USAGE ]
CPU em uso: 3.9%
Núcleos   : 16
...
```
