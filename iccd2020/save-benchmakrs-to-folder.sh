#!/bin/bash

# This script is meant to be run from inside tensorflow folder.
# The tensorflow folder is expected to have build folders such as
# `./bazel-bin`

# Depends on benchmark_model binary, thus compilation of this binary is expected:
# bazel build --copt=-mavx tensorflow/lite/tools/benchmark:benchmark_model
# bazel build --copt=-mavx2 tensorflow/lite/tools/benchmark:benchmark_model
# bazel build --copt=-mfma tensorflow/lite/tools/benchmark:benchmark_model
# bazel build --copt=-msse4.1 tensorflow/lite/tools/benchmark:benchmark_model
# bazel build --copt=-msse4.2 tensorflow/lite/tools/benchmark:benchmark_model
# bazel build --copt=-march=native tensorflow/lite/tools/benchmark:benchmark_model

if [ $# -eq 0 ]
  then
    echo "ERROR: No arguments supplied"
    echo "Run this script from inside tensorflow folder. Usage:"
    echo "./script <folder-to-save-logs>"

else

  BIN_ROOT=/working_dir/tensorflow/./bazel-bin/tensorflow/lite/tools/benchmark/benchmark_model
  MODELS_ROOT=/working_dir/tensorflow-models/iccd2020
  LOG_DIR=$1
  mkdir -p $LOG_DIR

  # Sweep Parameters
  N_THREADS_ARRAY=( 1 4 )
  MODEL_PATH_ARRAY=( 
    $MODELS_ROOT/mobilenet-v1-quant/mobilenet_v1_1.0_224_quant.tflite
    $MODELS_ROOT/mobilenet-v1-float/mobilenet_v1_1.0_224.tflite
    $MODELS_ROOT/mobilenet-v2-quant/mobilenet_v2_1.0_224_quant.tflite
    $MODELS_ROOT/mobilenet-v2-float/mobilenet_v2_1.0_224.tflite
    $MODELS_ROOT/resnet-v2-float/resnet_v2_101_299.tflite
  )
  for MODEL_PATH in "${MODEL_PATH_ARRAY[@]}"; do

    MODEL_TYPE_TMP=$(dirname "$MODEL_PATH")
    MODEL_TYPE=$(basename "$MODEL_TYPE_TMP")

    echo "Running ${MODEL_TYPE} ..."
    for N_THREADS in "${N_THREADS_ARRAY[@]}"; do
        echo "Saving to $LOG_DIR/${MODEL_TYPE}_${N_THREADS}t.log"
        $BIN_ROOT \
            --use_gpu=false --num_threads=$N_THREADS \
            --enable_op_profiling=true \
            --graph=$MODEL_PATH \
            > $LOG_DIR/${MODEL_TYPE}_${N_THREADS}t.log
    done
  done
fi
