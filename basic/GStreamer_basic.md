# GStreamer Cmd Programing
　本ドキュメントはGStreamerにおいて基本となるコマンドを学習することが目的です。

参考：https://github.com/matthew1000/gstreamer-cheat-sheet/blob/master/tee.md

<br>

# GStreamer 基本コマンド
## 超基本
- **エレメントの一覧を表示**
```
gst-inspect-1.0
```

- **エレメントの詳細情報を表示**
```
gst-inspect-1.0 rtph264pay
```

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


<br>

## 基本コマンド
- **テストビデオ信号の表示**
```
gst-launch-1.0 videotestsrc ! autovideosink
```

- **ウェブカメラの表示**
```
gst-launch-1.0 mfvideosrc ! videoconvert ! autovideosink
```
`mfvideosrc`: Windows用のGStreamerプラグインで、DirectShow APIを使用してカメラから映像をキャプチャする。`device-index`を指定することでカメラを選択できる

`videoconvert`: カメラからの映像データを、GStreamerが扱える形式に変換する

`autovideosink`: 変換された映像データを表示する


- **ウェブカメラの映像を保存する(mp4)**
```
gst-launch-1.0 -e mfvideosrc device_index=0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! x264enc ! mp4mux ! filesink location=output.mp4
```

`image/jpeg,width=640,height=480,framerate=30/1`: カメラからの生のビデオフレームを扱うためのgstreamerのフォーマット設定。この場合は、画像の幅が640ピクセル、高さが480ピクセルに設定

`jpegdec`: JPEG画像をデコードする

`videoconvert`: ビデオフレームを別のフォーマットに変換するためのgstreamerのエレメント。この場合、エンコードの前に必要なRGB形式に変換

`x264enc`: H.264形式でエンコードする
※ビットレート(bitrate=500 etc...)を指定しない場合、ファイルサイズが非常に大きくなる。

`mp4mux`: ビデオとオーディオストリームを結合し、MP4ファイルに出力する

`filesink `: 出力ファイルの保存先を指定する

- **ウェブカメラの映像を30fpsにコンバートしてから保存する(mp4)**
```
gst-launch-1.0 -e mfvideosrc device_index=0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! videorate ! video/x-raw,framerate=30/1 ! x264enc ! mp4mux ! filesink location=output.mp4
```


- **deviec-pathを指定して表示する**
``` 
gst-launch-1.0 -e mfvideosrc device-path="\\\\\?\\usb\#vid_046d\&pid_08e3\&mi_00\#8\&388279bb\&0\&0000\#\{e5323777-f976-4f5b-9b55-b94699c46e44\}\\global" ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! x264enc ! mp4mux ! filesink location=output.mp4
```

- **queueを分け、ウェブカメラの映像を二つの列に分ける**

```
gst-launch-1.0 -e mfvideosrc device_index=0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! tee name=t ! queue ! videoconvert ! x264enc ! mp4mux ! filesink location=output1.mp4 t. ! queue ! videoconvert ! x264enc ! mp4mux ! filesink location=output2.mp4
```


`tee name=t`: ビデオストリームを分岐させるためのgstreamerのエレメント。「t」という名前で分岐させる。ぶんきの最後に`t. `として列の最後の合図を送る。

`queue`: 列の最初につける

- **fpsの値を画面に表示する**
```
gst-launch-1.0 -e mfvideosrc device_index=0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! fpsdisplaysink video-sink="d3dvideosink"

```
# GStreamer 応用コマンド
- **テスト映像を他のPCに送信する**
```
gst-launch-1.0 videotestsrc ! videoconvert ! x264enc speed-preset=ultrafast tune=zerolatency bitrate=500 ! video/x-h264,profile=baseline ! rtph264pay ! udpsink host=192.168.0.28 port=100
```

送信先のIPアドレスを確かめる必要がある。
`videoconvert`: フォーマット変換のためのGStreamerエレメント。ここでは、YUY2フォーマットからx264encに必要なBGRxフォーマットに変換

`x264enc speed-preset=ultrafast tune=zerolatency bitrate=500`: H.264ビデオエンコーダーであるx264encの設定を行うGStreamerエレメント。speed-preset引数により、エンコードの速度/品質バランスを設定し、tune引数により、特定の遅延目標に最適化するようにエンコードするように指定。また、bitrate引数により、ビットレートを設定
- `x264enc`の引数について
  - `speed-preset`: エンコードの速度/品質バランスを設定
  - `tune`: 特定の遅延目標に最適化するようにエンコードする
  - `bitrate`: ビットレートを設定


`video/x-h264,profile=baseline`: エンコードされたビデオのフォーマットをH.264に変更するためのGStreamerキャプチャフィルター。ここでは、ビデオのプロファイルをBaselineに設定

`rtph264pay`: RTPパケットにエンコードされたH.264ビデオフレームをパッケージ化するためのエレメント
udpsink host=<送信先IPアドレス> port=<ポート番号>パッケージ化されたビデオフレームをUDPパケットとして送信するためのエレメント。host引数により、パケットの送信先IP
<br>
- **他のPCから映像を受信する**
```
gst-launch-1.0 udpsrc port=100 ! application/x-rtp,encoding-name=H264,payload=96 ! rtph264depay ! avdec_h264 ! autovideosink
```
`udpsrc` : UDPソケットを介してデータを受信するGStreamer

`application/x-rtp,encoding-name=H264,payload=96`: RTPパケットのエンコーディング方式を指定するためのパラメータ, Payload Typeは、このデータの種類に応じて識別するために使用され、例えば、Payload Typeが96であれば、そのRTPパケットに含まれるデータがH264形式のビデオデータである

`rtph264depay`: RTPパケットからH264パケットを抽出する。このエレメントは、application/x-rtpパラメータに従ってパケットをデマルチプレックスする

`avdec_h264`: H264ビデオをデコードする。このエレメントは、rtph264depayからのH264パケットをデコードし、rawビデオストリームを生成する。

`autovideosink`: デコードされたビデオを表示する。
<br>

- **テストビデオを表示しながら保存する**
```
gst-launch-1.0 -e videotestsrc ! videoconvert ! tee name=t ! queue ! autovideosink async-handling=false t. ! queue ! x264enc ! mp4mux ! filesink location=output.mp4 async=false
```
async=falseを使用することがポイント
<br>

- **カメラ映像を表示しながら保存する**
```
gst-launch-1.0 -e mfvideosrc device_index=0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! tee name=t ! queue ! autovideosink async-handling=false t. ! queue ! x264enc ! mp4mux ! filesink location=output.mp4 async=false
```

- **カメラ映像を分割保存しながら表示する。**
```
gst-launch-1.0 -e mfvideosrc device_index=0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! tee name=t ! queue ! autovideosink async-handling=false t. ! queue ! x264enc ! mp4mux ! filesink location=output.mp4 async=false
```
<br>

- **カメラ映像を保存しながら他のPCに送信する**

```
gst-launch-1.0 -e mfvideosrc device_index=0 ! image/jpeg,width=640,height=480,framerate=30/1 ! jpegdec ! videoconvert ! tee name=t ! queue ! x264enc speed-preset=ultrafast tune=zerolatency bitrate=500 ! video/x-h264,profile=baseline ! rtph264pay ! udpsink host=192.168.0.28 port=100 t. ! queue ! x264enc ! mp4mux ! filesink location=output.mp4 async=false
```



- **処理負荷を計測** 
```
GST_DEBUG=stats gst-launch-1.0 -e videotestsrc ! video/x-raw,width=640,height=480,framerate=30/1 ! videoconvert ! x264enc bitrate=2000 ! mp4mux ! filesink location=testvideo.mp4
```
