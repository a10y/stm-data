#!/usr/bin/env bash

# Fail quickly
set -eu -o pipefail

# Run all of the scripts
echo "Running Figure 2"
./run_verizon.sh

# Cleanup mosh processes in between
pkill mosh-server

echo "Running high delay"
./run_high_delay.sh

echo "Running high loss"
./run_high_loss.sh

echo "Running adversarial"
./run_adversarial.sh

echo "Generating plots..."
python plots.py
