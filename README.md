# Reproducing Mosh Results
---

1. Install Dependencies
2. Build & Install Mosh + MahiMahi
3. Run our scripts to reproduce the results

## 1. Install Required Dependencies

SSH into the GCE box, and run the following commands to install all dependencies:

```
# Build dependencies for Mosh + MahiMahi + stm-data
sudo apt-get install automake libtool g++ protobuf-compiler libprotobuf-dev \
                     libboost-dev libutempter-dev libncurses5-dev zlib1g-dev \
                     libio-pty-perl libssl-dev pkg-config install iptables \
                     dnsmasq-base apache2-bin apache2-dev autotools-dev \
                     dh-autoreconf iptables protobuf-compiler libprotobuf-dev \
                     pkg-config libssl-dev dnsmasq-base ssl-cert libxcb-present-dev \
                     libcairo2-dev libpango1.0-dev iproute2 apache2-dev apache2-bin \
                     python-numpy python-matplotlib
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

Gather the IP address of the machine, using `ifconfig`. As an example, if you run

```
$ ifconfig
ens4      Link encap:Ethernet  HWaddr 42:01:0a:80:00:02
          inet addr:10.128.0.2  Bcast:10.128.0.2  Mask:255.255.255.255
          inet6 addr: fe80::4001:aff:fe80:2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1460  Metric:1
          RX packets:8881 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5494 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4680905 (4.6 MB)  TX bytes:980238 (980.2 KB)
...
```

Your IP address is `10.128.0.2`. Save this to your environment:

```
export SSH_IP=1.2.3.4 # Use the IP address from ifconfig
```

Then, invoke the run_verizon.sh script:

```
./run_verizon.sh key-traces/
```


## 4. Notes

Cleaning up Mosh processes:

The following command will kill all running Mosh processes on the machine:

```
pkill mosh-server
```
