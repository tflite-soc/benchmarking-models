Use the script in this folder to benchmark several modules.

This script expects:

* Tensorflow benchamark_model binary compiled in tensorflow submodule
* Models downloaded in tensorflow-models/iccd submodule


To compile:
```
bazel build --copt=-mavx tensorflow/lite/tools/benchmark:benchmark_model
bazel build --copt=-mavx2 tensorflow/lite/tools/benchmark:benchmark_model
bazel build --copt=-mfma tensorflow/lite/tools/benchmark:benchmark_model
bazel build --copt=-msse4.1 tensorflow/lite/tools/benchmark:benchmark_model
bazel build --copt=-msse4.2 tensorflow/lite/tools/benchmark:benchmark_model
bazel build --copt=-march=native tensorflow/lite/tools/benchmark:benchmark_model
```

To run:
```
save-benchmakrs-to-folder.sh tmp/<opt-used-in-compilation>
```
