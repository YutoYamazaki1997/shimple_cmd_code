# dlstreamerの使用方法
## 参考
- [Git hub](https://github.com/dlstreamer/dlstreamer)
- [dls installガイド](https://dlstreamer.github.io/get_started/install/install_guide_ubuntu.html)
## 環境構築方法
### docker Imageのビルド
　下記を記述したdockerfileを作成する

```
docker build . -t dls:yydls
```


### container作成
runコマンドでcontainerを作成する。イメージがない場合は自動的にイメージをダウンロードする。
```
docker run -it --privileged --net=host \
   --device /dev/dri \
   -v ~/.Xauthority:/home/dlstreamer/.Xauthority \
   -v /tmp/.X11-unix \
   -e DISPLAY=$DISPLAY \
   -v /dev/bus/usb \
   --rm intel/dlstreamer:devel /bin/bash

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