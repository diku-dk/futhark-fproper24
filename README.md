# Experimental infrastructure for the paper *A comparison of OpenCL, CUDA, and HIP as compilation targets for a functional array language*

This repository contains various scripts for reproducing the
experiment in the paper. In particular, it contains scripts for
executing the [Futhark benchmark
suite](https://github.com/diku-dk/futhark-benchmarks) using two
backends (either CUDA/OpenCL or HIP/OpenCL), and comparing their
results.

There is no attempt at automatically analysing the *cause* of
performance differences - this remains a (very) laborious manual
process - although some notes on the procedure can be found below.

The benchmark suite is included as a Git submodule, pinned to a
specific commit. It will work with **Futhark 0.25.17**, which was also
used for the results in the paper. Future users of this infrastructure
are likely interested in using newer versions of the compiler and the
benchmark suite, and it is discussed below how to do this.

## Dependencies

1) An appropriate version of the Futhark compiler must be available in
   your `PATH`. The paper used 0.25.17. [See this directory of
   Futhark tarballs.](https://futhark-lang.org/releases/)

2) Your system (realistically, Linux) must have a correctly setup
   OpenCL installation, and either CUDA or HIP as well. By "correctly
   setup", we mean that `futhark opencl`, `futhark cuda`, and `futhark
   hip` work. This is equivalent to the C compiler being able to link
   with `-lOpenCL` (and equivalently for HIP and CUDA), as well as
   being able to find the necessary header files. If necessary, adjust
   the environment variables `CPATH`, `LD_LIBRARY_PATH`, etc. as
   appropriate.

3) Some reasonably recent version of Python 3, with Numpy.

4) [Gnuplot](http://gnuplot.info/).

5) The `sha256sum` executable must be on your `PATH`.

## Running

First, do `make prepare` to download the benchmark datasets. This
takes about 33GiB of space. You only need to do this once.

### With an NVIDIA GPU

Run `make cuda-vs-opencl.pdf` to benchmark with CUDA, then with OpenCL,
and finally produce a speedup graph similar to Figure 2a of the paper.

### With an AMD GPU

Run `make hip-vs-opencl.pdf` to benchmark with HIP, then with OpenCL,
and finally produce a speedup graph similar to Figure 2b of the paper.

### Manually

The following instructions are useful if you want to adapt the
experimental infrastructure to new backends or different sets of
benchmarks.

The `plot-speedups.sh` script is what ultimately does the plotting. It
is run as follows:


```
$ ./plot-speedups.sh FOO.json BAR.json GRAPH.pdf
```

Where `FOO.json` and `BAR.json` are JSON files produced by the
`--json` option of the `futhark bench` tool. An example is:

```
$ futhark bench futhark-benchmarks --ignore=/lib/ --backend=cuda --json cuda.json
```

The `plot-speedups.sh` script contains some logic for disregarding
benchmarks that were not included in the paper, although results for
these are still present in the JSON files produced by `futhark bench`.
You can edit the `plot-speedups.sh` script to change which benchmarks
are plotted.
