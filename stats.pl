#!/usr/bin/env perl

use warnings;
use strict;

my $filename = $ARGV[0];
open my $fh, '<', $filename;

# calc mean
my @values = ();
while (<$fh>) {
    chomp;
    push @values, ($_ + 0.0);
}

@values = sort @values;

my $sum = 0.0;
foreach (@values) {
    $sum += $_;
}

# Mean
my $mean = $sum / scalar(@values);

# If even, perform averaging
my $median;
if (scalar(@values) % 2 == 0) {
    $median = 0.5 * $values[scalar(@values) / 2] + 0.5*$values[scalar(@values)/2 - 1];
} else {
    $median = $values[scalar(@values) / 2];
}

# Stddev
my $variance = 0.0;
foreach (@values) {
    my $diff = $_ - $mean;
    $diff *= $diff;
    $variance += $diff;
}
$variance /= scalar(@values);
my $stddev = sqrt($variance);

printf "Points: %d\n", scalar(@values);
printf "Mean: %f\n", $mean;
printf "Median: %f\n", $median;
printf "Variance: %f\n", $variance;
printf "Stddev: %f\n", $stddev;
