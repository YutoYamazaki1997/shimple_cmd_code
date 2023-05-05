# Ubuntu環境へのセットアップ　
## はじめに
本ドキュメントはオフラインのUbuntu22.04にGStreamerを扱うために必要なパッケージをInstallする方法を記載します。

参考：https://iyuniy.hatenablog.com/entry/2020/05/06/223940

# 必要なもの
- WSL2が導入されているWindows PC(環境がきれいな方がやりやすい)
- USBメモリ

# WSL2で必要なファイルを用意する
1. Windowsのアプリ→インストールされているアプリ→Ubuntuからリセットを選択し、WSL2環境をリセットする

2. Windows PowerShellを起動し、以下のコマンドを実行しする
   ```wslconfig /u Ubuntu```

3. Ubuntuを起動し、ユーザー登録し、
   ```sudo apt update```
   その後、
   ```sudo apt upgrade```
## VLC Media PlayerのInstall
```sudo apt-get install --download-only vlc```
　実行すると`/var/cache/apt/archives`にdebファイル(インストールに必要なパッケージ)がダウンロードされる。
　その後、`deb_vlc`等のフォルダにdebファイルをコピーし、USBに保存する

## GStreamer
  ```
  sudo apt-get install --download-only gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav
  ```


ダウンロード後は同様

## VSCode
- https://code.visualstudio.com/
  のLinuxを選択し、ダウンロード。その後
```sudo dpkg -i deb_vscode/*.deb```
### 拡張機能
- https://marketplace.visualstudio.com/
  のDownload Extensionから拡張機能のVSIXファイルをダウンロードし、USBメモリに挿入。その後、拡張機能の‥からインストール

## Python
### ビルドツールの取得
  wsl2で以下のパッケージをinstallする
  ```
sudo apt-get update
sudo apt-get --download-only install libssl-dev zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev libffi-dev wget

  ```

  build-essentialの必要なパッケージ
  ```
  sudo apt-get --download-only install binutils
  ```

  ```
  sudo apt-get --download-only install build-essential 
  ```

### Python本体の取得
https://www.python.org/ftp/python/3.8.10/

のGzipped sorce tarballからtar.xzファイルを取得

### ライブラリの取得
https://pypi.org/
からtar.xzファイルを取得

## GStreamer_Pythonラッパー
```
sudo apt-get --download-only install python3-gi
```

# Ubuntu PCで環境を作成
## 通常のパッケージ
パッケージがまとまったフォルダに対し、
```sudo dpkg -i *.deb```
でinstallが開始される。


## Python
[参考](https://www.python.jp/install/ubuntu/index.html)
- 解凍`tar xJf Python-3.8.10.tar.xz`


  ```
  $ cd Python-3.x.y
  $ ./configure
  $ もしくは bash \configure
  $ make
  $ sudo make install
  ```
## Pythonのライブラリ
