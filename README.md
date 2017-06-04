# Reproducing Mosh Results
---

1. Install Dependencies
2. Build & Install Mosh + MahiMahi
3. Run our scripts to reproduce the results

## 1. Install Required Dependencies + Build

This is handled in a single script which downloads all dependencies, builds
the projects and sets up no-password SSH using public key auth

```
./setup.sh
```

## 2. Extra setup

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
export SSHIP=1.2.3.4 # Use the IP address from ifconfig
```

**IMPORTANT**: SSH the first time by hand to the `$SSHIP`:

```
ssh $SSHIP    # Say "yes" to accept the host key
```

## 3. Run the Scripts

Run all the scripts and generate the plots:

```
./run.sh   # Runs all scripts, dumps plots.
```

The following plots will be generated in this directory:

* `figure2-plot.png`
* `high_delay-plot.png`
* `high_loss-plot.png`

You're going to want to SCP those back to your machine to view them.

To see statistical information about the high_delay and high_loss similar
to what's in the tables in section 4, run the following two commands:

```
# Stats for high delay
./stats.pl high_delay.mosh.delay
./stats.pl high_delay.ssh.delay

# Stats for high loss
./stats.pl high_loss.mosh.delay
./stats.pl high_loss.ssh.delay
```

