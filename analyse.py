#!/usr/bin/env python3

import numpy as np
import json
import sys
import os

_, jsonf_a, jsonf_b = sys.argv

json_a = json.load(open(jsonf_a))
json_b = json.load(open(jsonf_b))

speedups={}

prefix=os.path.commonprefix(list(json_a.keys()))

for benchmark in json_a:
    xs=[]
    stddevs=[]
    for dataset in json_a[benchmark]['datasets']:
        a_runtimes = np.array(json_a[benchmark]['datasets'][dataset]['runtimes'])
        b_runtimes = np.array(json_b[benchmark]['datasets'][dataset]['runtimes'])
        n = min(a_runtimes.shape[0], b_runtimes.shape[0])
        mean_a = np.mean(a_runtimes)
        mean_b = np.mean(b_runtimes)
        xs += [mean_a / mean_b]
        stddevs += [np.std(a_runtimes[:n] / b_runtimes[:n])]
    if len(xs) > 0:
        speedups[benchmark[len(prefix):]] = (np.mean(xs), np.std(xs))

for (benchmark,(s,dev)) in sorted(list(speedups.items()), key=lambda x: x[1]):
    print('%60s %.3f %.3f' % (benchmark, s, dev))
