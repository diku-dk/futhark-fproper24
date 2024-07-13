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
