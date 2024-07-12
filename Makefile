FUTHARK?=futhark
BENCHMARKS?=futhark-benchmarks

all: a100-speedups.pdf a100-micro-speedups.pdf mi100-micro-speedups.pdf mi100-speedups.pdf

.SECONDARY:

.PHONY: compare-cuda-opencl compare-hip-opencl

all:
	echo "Use either 'make cuda-vs-opencl' or 'make hip-vs-opencl'."

cuda-vs-opencl:
	$(FUTHARK) bench $(FUTHARK_BENCHMARKS) --ignore=/lib/ --backend=cuda --json cuda.json
	$(FUTHARK) bench $(FUTHARK_BENCHMARKS) --ignore=/lib/ --backend=opencl --json opencl.json
	./plot-speedups.sh cuda.json opencl.json cuda-vs-opencl.pdf

hip-vs-opencl:
	$(FUTHARK) bench $(FUTHARK_BENCHMARKS) --ignore=/lib/ --backend=hip --json hip.json
	$(FUTHARK) bench $(FUTHARK_BENCHMARKS) --ignore=/lib/ --backend=opencl --json opencl.json
	./plot-speedups.sh hip.json opencl.json hip-vs-opencl.pdf
