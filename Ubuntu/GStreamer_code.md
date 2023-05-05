- **使用可能なデバイスを表示**
```
gst-device-monitor-1.0
```
- **ログを取得する方法**
  - 環境変数にdebugレベルを設定する
  ```
  set GST_DEBUG=4
  ```
  <br>
  
  - ログファイルを指定する
  ```
  set GST_DEBUG_FILE=gstreamer.log
  ```
  
  - コマンドの後ろに以下をつけることでもエラーログは取得できる
   
  ```2> error.log```

## 基本コマンド
- **テストビデオ信号の表示**
```
gst-launch-1.0 videotestsrc ! autovideosink
```

- **ウェブカメラの表示**
```
gst-launch-1.0 v4l2src device=/dev/video0 ! videoconvert ! autovideosink
```


- **ウェブカメラの映像を保存する(mp4)**
```
gst-launch-1.0 -e v4l2src device=/dev/video0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! x264enc ! mp4mux ! filesink location=output.mp4
```


- **ウェブカメラの映像を分割しながら保存する(mp4)**
```
gst-launch-1.0 -e v4l2src device=/dev/video0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! x264enc ! splitmuxsink max-size-time=20000000000 location=output%02d.mp4 muxer=mp4mux
```

- **カメラ映像を保存しながら他のPCに送信する**

```
gst-launch-1.0 -e v4l2src device=/dev/video0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! tee name=t ! queue ! x264enc speed-preset=ultrafast tune=zerolatency bitrate=500 ! video/x-h264,profile=baseline ! rtph264pay ! udpsink host=192.168.0.28 port=100 t. ! queue ! x264enc ! mp4mux ! filesink location=output.mp4 async=false
```

- **これでもいいかも**

```
gst-launch-1.0 -e v4l2src device=/dev/video0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! x264enc ! tee name=t ! queue ! video/x-h264,profile=baseline ! rtph264pay ! udpsink host=192.168.0.28 port=100 t. ! queue ! mp4mux ! filesink location=output.mp4 async=false
```