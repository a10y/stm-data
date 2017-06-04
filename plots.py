import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

def read_values(fname):
    values = []
    with open(fname, 'r') as f:
        for line in f:
            line = line.strip()
            values.append(float(line))
    return values

def gen_plot(session, scale, title):
    # Read the dataset from argv[1]
    mosh_fname = "%s.mosh.delay" % session
    ssh_fname = "%s.ssh.delay" % session

    # Read values from file
    mosh_values = sorted(read_values(mosh_fname))
    ssh_values = sorted(read_values(ssh_fname))

    mosh_ys = [float(i+1)/len(mosh_values) for i in range(len(mosh_values))]
    ssh_ys = [float(i+1)/len(ssh_values) for i in range(len(ssh_values))]

    plt.figure()

    plt.axis(scale)

    plt.plot(mosh_values, mosh_ys, label='Mosh')
    plt.plot(ssh_values, ssh_ys, label='SSH')

    #plt.plot(mosh_base[:-1], mosh_vals, c='blue', label='Mosh')
    #plt.plot(ssh_base[:-1], ssh_vals, c='red', label='SSH')

    plt.xlabel('Keystroke response time (s)')
    plt.ylabel('Percentage')
    plt.title(title)
    plt.legend(loc=4)

    plt.savefig('%s-plot.png' % session)

gen_plot('high_delay', [0.0, 7.0, 0, 1.0], 'Cumulative distribution of keystroke response times with 5s RTT')
gen_plot('high_loss', [0.0, 2.0, 0, 1.0], 'Cumulative distribution of keystroke response times with 50% round-trip loss and no Mosh speculation')
gen_plot('figure2', [0.0, 1.0, 0, 1.0], 'Cumulative distribution of keystroke response times with 500ms RTT and Verizon LTE Characteristics')
gen_plot('adversarial', [0.0, 1.0, 0, 1.0], 'Cumulative distribution of keystroke response times with an adversarial key-trace')
