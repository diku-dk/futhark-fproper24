FUTHARK?=futhark
BENCHMARKS?=futhark-benchmarks

.SECONDARY:

.PHONY: compare-cuda-opencl compare-hip-opencl

all:
	echo "Use either 'make cuda-vs-opencl' or 'make hip-vs-opencl'."

cuda-vs-opencl:
	$(FUTHARK) bench $(BENCHMARKS) --ignore=/lib/ --backend=cuda --json cuda.json
	$(FUTHARK) bench $(BENCHMARKS) --ignore=/lib/ --backend=opencl --json opencl.json
	./plot-speedups.sh cuda.json opencl.json cuda-vs-opencl.pdf

hip-vs-opencl:
	$(FUTHARK) bench $(BENCHMARKS) --ignore=/lib/ --backend=hip --json hip.json
	$(FUTHARK) bench $(BENCHMARKS) --ignore=/lib/ --backend=opencl --json opencl.json
	./plot-speedups.sh hip.json opencl.json hip-vs-opencl.pdf
