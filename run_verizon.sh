#!/bin/bash
# Usage: ./run_verizon.sh <input trace file>

# Fail quickly
set -eu -o pipefail

if [[ "$(sysctl net.ipv4.ip_forward)" =~ "0" ]]; then
	echo "Enabling ip forwarding for mahimahi..."
	sudo sysctl -w net.ipv4.ip_forward=1
fi

# Ensure that the MYIP variable is defined
if [[ -z ${SSHIP+x} ]]; then
	echo "Please set the variable SSHIP to the IP address you want to SSH/Mosh into."
	exit 1
fi


SESS="session_$((RANDOM % 1000))"

echo "Session: $SESS"

# Run the SSH script
# mm-delay 100 mm-link ./traces/Verizon-LTE-short.up ./traces/Verizon-LTE-short.down ./term-replay-client $1 $SESS ssh $SSHIP ~/stm-data/term-replay-server ~/stm-data/$1

# Run the Mosh script
mm-delay 100 mm-link ./traces/Verizon-LTE-short.up ./traces/Verizon-LTE-short.down ./term-replay-client $1 $SESS mosh "$SSHIP -- sh -c \"cd stm-data && ./term-replay-server $1\""

echo "Saved Session: $SESS"
