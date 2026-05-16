#!/bin/bash

# ================================
# Server Performance Stats
# ================================

echo "=============================="
echo "   SERVER PERFORMANCE STATS   "
echo "=============================="
echo "Data: $(date)"
echo ""

# --- CPU ---
echo "[ USO DE CPU ]"
CPU_IDLE=$(top -bn1 | grep "id," | awk '{print $8}' | tr ',' '.')
CPU_USED=$(echo "100 - $CPU_IDLE" | bc)
# --- NÚMERO DE NÚCLEOS ---
NUCLEOS=$(nproc)
echo "CPU em uso: ${CPU_USED}%"
echo "Núcleos   : ${NUCLEOS}"
echo ""

# --- MEMÓRIA ---
echo "[ MEMÓRIA ]"
MEM_TOTAL=$(LANG=C free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(LANG=C free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(LANG=C free -m | awk '/Mem:/ {print $4}')
MEM_PCT=$(echo "scale=1; $MEM_USED * 100 / $MEM_TOTAL" | bc)
echo "Total : ${MEM_TOTAL} MB"
echo "Usada : ${MEM_USED} MB"
echo "Livre : ${MEM_FREE} MB"
echo "Uso   : ${MEM_PCT}%"
echo ""

# --- DISCO ---
echo "[ USO DE DISCO ]"
LANG=C df -h | grep -E '^/dev/' | while read line; do
    MOUNT=$(echo $line | awk '{print $6}')
    TOTAL=$(echo $line | awk '{print $2}')
    USED=$(echo $line  | awk '{print $3}')
    FREE=$(echo $line  | awk '{print $4}')
    PCT=$(echo $line   | awk '{print $5}')
    echo "Partição $MOUNT — Total: $TOTAL | Usado: $USED | Livre: $FREE | Uso: $PCT"
done
echo ""

# --- TOP 5 CPU ---
echo "[ TOP 5 PROCESSOS POR CPU ]"
printf "%-6s %-10s %-5s %s\n" "PID" "USER" "%CPU" "COMANDO"
LANG=C ps aux --sort=-%cpu | awk 'NR>1 {printf "%-6s %-10s %-5s %s\n", $2, $1, $3, $11}' | head -5
echo ""

# --- TOP 5 MEMÓRIA ---
echo "[ TOP 5 PROCESSOS POR MEMÓRIA ]"
printf "%-6s %-10s %-5s %s\n" "PID" "USER" "%MEM" "COMANDO"
LANG=C ps aux --sort=-%mem | awk 'NR>1 {printf "%-6s %-10s %-5s %s\n", $2, $1, $4, $11}' | head -5
echo ""

# --- INFORMAÇÕES DO SISTEMA ---
echo "[ INFORMAÇÕES DO SISTEMA ]"
echo "OS      : $(lsb_release -d | awk -F: '{print $2}' | xargs)"
echo "Kernel  : $(uname -r)"
echo "Uptime  : $(uptime -p)"
echo "Carga   : $(uptime | awk -F'load average:' '{print $2}')"
echo ""

# --- USUÁRIOS CONECTADOS ---
echo "[ USUÁRIOS CONECTADOS ]"
who
echo ""

# --- TENTATIVAS DE LOGIN FALHAS ---
echo "[ TENTATIVAS DE LOGIN FALHAS ]"
FALHAS=$(lastb 2>/dev/null | grep -c .)
echo "Total de tentativas falhas: ${FALHAS}"
echo ""



