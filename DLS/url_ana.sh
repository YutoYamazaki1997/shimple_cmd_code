#!bin/bash
set -e

INPUT=$"https://github.com/intel-iot-devkit/sample-videos/raw/master/face-demographics-walking.mp4"
DEVICE='CPU'
SOURCE_ELEMENT="urisourcebin buffer-size=4096 uri=${INPUT}"


rm -f output.json
SINK_ELEMENT="gvawatermark ! gvametaconvert add-tensor-data=true ! gvametapublish file-format=json-lines file-path=output.json ! videoconvert ! gvafpscounter ! autovideosink sync=false"


HPE_MODEL_PATH='human-pose-estimation-0001.xml'
HPE_MODEL_PROC='model_proc.json'
PIPELINE="gst-launch-1.0 $SOURCE_ELEMENT ! decodebin ! \
gvaclassify model=$HPE_MODEL_PATH model-proc=$HPE_MODEL_PROC device=$DEVICE inference-region=full-frame ! queue ! \
$SINK_ELEMENT"

echo ${PIPELINE}
$PIPELINE