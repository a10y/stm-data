#!/bin/bash
# Usage: sh run_verizon.sh <mosh or ssh> <keyword> <input trace file>
[[ "$(sysctl net.ipv4.ip_forward)" =~ "0" ]] && sudo sysctl -w net.ipv4.ip_forward=1

mm-delay 20 mm-link ./traces/Verizon-LTE-short.up ./traces/Verizon-LTE-short.down ./term-replay-client $3 $2 $1 "192.168.171.10 -- sh -c \"cd stm-data && ./term-replay-server $3\""
