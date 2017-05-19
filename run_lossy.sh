# Usage: sh run_lossy.sh <mosh or ssh> <keyword> <input trace file>

mm-delay 100 mm-loss uplink 0.29 mm-loss downlink 0.29 ./term-replay-client $3 $2 $1 192.168.171.10 "cd stm-data && ./term-replay-server $3"
