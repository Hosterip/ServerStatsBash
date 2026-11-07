#!/bin/bash

basic_stats () {
    CPU_USAGE=$(top -b -n 1 | grep Cpu | awk '{printf "%.2f\%\n", $2}' 2>/dev/null) 
    MEMORY_INFO=$(free -lhw | sed -n '2p' | awk '{ percent = 100 * $3 / $2 ;
    printf "%.2f\% ", percent ;
    print $3, $4, $2 }' 2>/dev/null)
    ROOT_INFO=$(df -h | sed -n '2p' | awk '{ print $5, $3, $4, $2 }' 2>/dev/null)
    cat <<EOF | column -t
TYPE USE% USED FREE TOTAL  
CPU: $CPU_USAGE
MEMORY: $MEMORY_INFO
ROOT_FS: $ROOT_INFO
EOF
}

top_cpu_usage () {
    top -b -n 10 -o '%CPU' | tail -n +7 | head -n 6 | column -t 
}

top_memory_usage () {
    top -b -n 10 -o '%MEM' | tail -n +7 | head -n 6 | column -t 
}

basic_stats
echo "TOP 5 PROCESSES SORTED BY %CPU"
top_cpu_usage
echo "TOP 5 PROCESSES SORTED BY %MEM"
top_memory_usage
