# benchmarking-models
Benchmark and graph results for different targets running different models

## How to collect results?

Using the benchmarking tool provided in ????.

```
./benchmark_model \
    --use_gpu=false \
    --enable_op_profiling=true \
    --graph=../../tensorflow-models/mobilenet-v1/mobilenet_v1_1.0_224_quant.tflite > <YYYY-MM-DD>-<platform>-<n-of-cores>c.txt
```

## Prefered folder-file structure

```
.
├── <network-name>_<version>_<inputsize>_<features>
│   └── <YYYY-MM-DD>-<platform>-<n-of-cores>c.txt
├── mobilenet_v1_1.0_224_quant
│   └── 2019-11-11-zedboard-2c.txt
```
# LICENSE Note

This repository is licensed under the [Apache License 2.0](LICENSE)

However, scripts in this repository may download external files that comply with
other licenses.