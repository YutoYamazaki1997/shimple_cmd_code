# dlstreamerの使用方法
## 参考
- [Git hub](https://github.com/dlstreamer/dlstreamer)
- [dls installガイド](https://dlstreamer.github.io/get_started/install/install_guide_ubuntu.html)
## 環境構築方法
### docker Imageのビルド
　下記を記述したdockerfileを作成する
```
FROM intel/dlstreamer:devel
USER root
RUN mkdir -p /var/lib/apt/lists/partial
RUN apt-get update && apt-get install -y gstreamer1.0-plugins-ugly
RUN apt-get update && apt-get install -y gstreamer1.0-plugins-good
```
続いて、このDockerfile

```
docker build . -t dls:yydls
```


### container作成
runコマンドで先ほどビルドしたimageを使用し、containerを作成する。
```
docker run -it --privileged --net=host \
   --device /dev/dri \
   -v /home/yamazayt/docker_folder:/home/dlstreamer/model \
   -v ~/.Xauthority:/home/dlstreamer/.Xauthority \
   -v /tmp/.X11-unix \
   -e DISPLAY=$DISPLAY \
   -v /dev/bus/usb \
   --rm dls:yydls /bin/bash
```

### 実行環境テスト
コンテナ内で以下のコマンドが動作することを確認する
```
gst-inspect-1.0 gvawatermark
```

### モデルファイルの取得
以下のコマンドを実行しモデルを取得する
```
/opt/intel/dlstreamer/samples
```

```
/home/dlstreamer/intel/dl_streamer/models/intel/human-pose-estimation-0001/FP32/human-pose-estimation-0001.xml
```
```
/opt/intel/dlstreamer/samples/gstreamer/gst_launch/human_pose_es
timation/model_proc/human-pose-estimation-0001.json
```
にモデルが保存されている。これらからマウントしているフォルダにコピーする。
```
cp /home/dlstreamer/intel/dl_streamer/models/intel/human-pose-estimation-0001/FP32/human-pose-estimation-0001.xml /home/dlstreamer/model/human-pose-estimation-0001.xml
```

```
cp /opt/intel/dlstreamer/samples/gstreamer/gst_launch/human_pose_estimation/model_proc/human-pose-estimation-0001.json /home/dlstreamer/model/model_proc.json
```

```
cp /home/dlstreamer/intel/dl_streamer/models/intel/human-pose-estimation-0001/FP32/human-pose-estimation-0001.bin /home/dlstreamer/model/human-pose-estimation-0001.bin
```