# Reproducing Mosh Results
---

1. Install Dependencies
2. Build & Install Mosh + MahiMahi
3. Run our scripts to reproduce the results

## 1. Install Required Dependencies

SSH into the GCE box, and run the following commands to install all dependencies:

```
# Build dependencies for Mosh + MahiMahi + stm-data
sudo apt-get install automake libtool g++ protobuf-compiler libprotobuf-dev libboost-dev libutempter-dev libncurses5-dev zlib1g-dev libio-pty-perl libssl-dev pkg-config install iptables dnsmasq-base apache2-bin apache2-dev autotools-dev dh-autoreconf iptables protobuf-compiler libprotobuf-dev pkg-config libssl-dev dnsmasq-base ssl-cert libxcb-present-dev libcairo2-dev libpango1.0-dev iproute2 apache2-dev apache2-bin python-numpy python-matplotlib
```

You'll also want to setup passwordless SSH:

```
ssh-keygen -t rsa -b 4096 # Hit enter at all the prompts
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

## 2. Build & Install Mosh + MahiMahi

```
# Make the stm-data repo

(cd ./dependencies/mosh && ./autogen.sh && ./configure && make && sudo make install)
(cd ./dependencies/mahimahi && ./autogen.sh && ./configure && make && sudo make install)
```

## 3. Run the Scripts

Cleaning up Mosh processes:

The following command will kill all running Mosh processes on the machine:

```
pkill mosh-server
```
