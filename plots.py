import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

import sys

if len(sys.argv) < 2:
    print "Need to supply SESSION"
    sys.exit(-1)

def read_values(fname):
    values = []
    with open(fname, 'r') as f:
        for line in f:
            line = line.strip()
            values.append(float(line))
    return values

# Read the dataset from argv[1]
session = sys.argv[1]
mosh_fname = "%s.mosh.delay" % session
ssh_fname = "%s.ssh.delay" % session

# Read values from file
mosh_values = read_values(mosh_fname)
ssh_values = read_values(ssh_fname)

# binning
mosh_vals, mosh_base = np.histogram(mosh_values, bins=100)
ssh_vals, ssh_base = np.histogram(ssh_values, bins=100)


mosh_cum = np.cumsum(mosh_vals)
ssh_cum = np.cumsum(ssh_vals)

print mosh_vals
print mosh_cum

plt.figure()

plt.axis([0, 0.3, 0, 1.0])

ax = plt.gca()
ax.hist(mosh_values, 100, normed=1, histtype='step', cumulative=True, label='Mosh')
ax.hist(ssh_values, 100, normed=1, histtype='step', cumulative=True, label='SSH')

#plt.plot(mosh_base[:-1], mosh_vals, c='blue', label='Mosh')
#plt.plot(ssh_base[:-1], ssh_vals, c='red', label='SSH')

plt.xlabel('Keystroke response time (s)')
plt.ylabel('Percentage')
plt.title('Cumulative Distribution of Keystroke Response Times Using Verizon LTE Traces')
plt.legend(loc=4)

plt.savefig('%s-plot.png' % session)
