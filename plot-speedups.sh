#!/bin/sh
#
# This script plots the speedups from one system to another.

set -e

if [ $# -ne 3 ]; then
    echo "Usage: $0 <JSON_A> <JSON_B> <PDF>"
    exit 1
fi

JSON_A=$1
JSON_B=$2
PDF=$3

# We filter away benchmarks that we decided not to include in the
# paper. These are mostly microbenchmarks (or obscure ones) that do
# not contribute any new insights, but would make the graph even more
# unreasonably large.
./analyse.py "$1" "$2" \
    | grep -v -E 'micro|tridiag-test|babelstream|accelerate/kmeans|misc|jgf|(quick|merge|radix)_sort\.fut:sort_(f64|i32)_pair' | \
    sed -e 's|^.*/||' -e 's|.fut||' -e 's|_|\\\\_|g' > speedups

gnuplot -e "datafile='speedups'" -e "plotfile='${PDF}'" speedups.gnuplot
