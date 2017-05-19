# Usage: sh run_verizon.sh <mosh or ssh> <keyword> <input trace file>

mm-link /usr/share/mahimahi/traces/Verizon-LTE-short.up /usr/share/mahimahi/traces/Verizon-LTE-short.down ./term-replay-client $3 $2 $1 192.168.171.10 "cd stm-data && ./term-replay-server $3"
