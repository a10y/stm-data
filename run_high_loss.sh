#!/bin/bash
# Usage: ./run_high_loss.sh

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


SESS="high_loss"

# Run the SSH script
mm-delay 50 mm-loss uplink 0.29 mm-loss downlink 0.29 ./term-replay-client key-traces/agd-trace-01 $SESS ssh $SSHIP ~/stm-data/term-replay-server ~/stm-data/key-traces/agd-trace-01

# Run the Mosh script
mm-delay 50 mm-loss uplink 0.29 mm-loss downlink 0.29 ./term-replay-client key-traces/agd-trace-01 $SESS mosh -n "$SSHIP -- sh -c \"cd stm-data && ./term-replay-server key-traces/agd-trace-01\""

echo "Saved Session: $SESS"
