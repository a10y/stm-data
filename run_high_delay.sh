#!/bin/bash
# Usage: ./run_high_delay.sh

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


SESS="high_delay"

# Run the SSH script
echo "Running SSH simulation:"
mm-delay 2500 mm-link ./traces/Verizon-LTE-short.up ./traces/Verizon-LTE-short.down ./term-replay-client key-traces/agd-short $SESS ssh $SSHIP ~/stm-data/term-replay-server ~/stm-data/key-traces/agd-short

# Run the Mosh script
echo "Running Mosh simulation:"
mm-delay 2500 mm-link ./traces/Verizon-LTE-short.up ./traces/Verizon-LTE-short.down ./term-replay-client key-traces/agd-short $SESS mosh "$SSHIP -- sh -c \"cd stm-data && ./term-replay-server key-traces/agd-short\""

echo "Saved Session: $SESS"
