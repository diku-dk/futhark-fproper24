FUTHARK?=futhark
BENCHMARKS?=futhark-benchmarks

.SECONDARY:

.PHONY: all prepare compare-cuda-opencl compare-hip-opencl

all: prepare

prepare:
	cd futhark-benchmarks && sh get-data.sh
	echo "Use either 'make cuda-vs-opencl.pdf' or 'make hip-vs-opencl.pdf'."

cuda-vs-opencl.pdf:
	$(FUTHARK) bench $(BENCHMARKS) --ignore=/lib/ --backend=cuda --json cuda.json
	$(FUTHARK) bench $(BENCHMARKS) --ignore=/lib/ --backend=opencl --json opencl.json
	./plot-speedups.sh cuda.json opencl.json cuda-vs-opencl.pdf

hip-vs-opencl.pdf:
	$(FUTHARK) bench $(BENCHMARKS) --ignore=/lib/ --backend=hip --json hip.json
	$(FUTHARK) bench $(BENCHMARKS) --ignore=/lib/ --backend=opencl --json opencl.json
	./plot-speedups.sh hip.json opencl.json hip-vs-opencl.pdf
