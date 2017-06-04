#!/usr/bin/env bash

# Run this script before run.sh

# Install all the dependencies via aptitude on Ubuntu
echo "Installing package (may prompt for password)"
sudo apt-get install -y automake libtool g++ protobuf-compiler libprotobuf-dev \
                        libboost-dev libutempter-dev libncurses5-dev zlib1g-dev \
                        libio-pty-easy-perl libssl-dev pkg-config iptables \
                        dnsmasq-base apache2-bin apache2-dev autotools-dev \
                        dh-autoreconf iptables protobuf-compiler libprotobuf-dev \
                        pkg-config libssl-dev dnsmasq-base ssl-cert \
                        libxcb-present-dev libcairo2-dev libpango1.0-dev \
                        iproute2 apache2-dev apache2-bin python-numpy \
                        python-matplotlib

echo "Generating SSH keypair, hit enter at all the prompts"
ssh-keygen -t rsa -b 4096

echo "Adding public key for no-password SSH login"
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

echo "Building mosh, mahimahi and stm-data (may take a few minutes)"
(cd ./dependencies/mosh && ./autogen.sh && ./configure && make && sudo make install)
(cd ./dependencies/mahimahi && ./autogen.sh && ./configure && make && sudo make install)
