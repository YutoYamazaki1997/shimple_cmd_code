# 参考
## 初めに
　本ドキュメントでは、オフライン環境のUbuntu PCにDockerをインストールする方法を記します。

### 参考
- [オフラインの環境でExploratory Collaboration Server、Exploratory Desktopをインストールする方法](https://exploratory.io/note/exploratory/Exploratory-Collaboration-Server-Exploratory-Desktop-pUy2myi2DE)

## ファイルの準備及びインストール
1. ネットワークに接続しているPCを使用し、Dockerの[ダウンロードページ](https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/)から以下の3つのファイルをローカルPCに保存する。Ubuntu 22.04.2であるなら下記ファイルを使用する
   - [containerd.io_1.6.20-1_amd64.deb](https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_1.6.20-1_amd64.deb)
   - [docker-ce_23.0.5-1~ubuntu.18.04~bionic_amd64.deb](https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_23.0.5-1~ubuntu.18.04~bionic_amd64.deb)
   - [docker-ce-cli_23.0.5-1~ubuntu.18.04~bionic_amd64.deb](https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_23.0.5-1~ubuntu.18.04~bionic_amd64.deb)
  その後、オフラインの環境にコピーし、debファイルからインストールする
   ```
   sudo dpkg -i *.deb
   ```
2. [docker composeの実行ファイル](docker-compose-plugin_2.17.3-1~ubuntu.18.04~bionic_amd64.deb)をインストールし、docker-composeという名前に変更する。その後、オフラインの環境にコピーし、debファイルからインストールする。なお権限変更後は再起動する必要あり
   ```
   sudo dpkg -i *.deb
   ```

...以上