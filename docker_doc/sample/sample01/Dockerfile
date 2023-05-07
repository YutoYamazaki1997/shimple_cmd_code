FROM ubuntu:latest

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y python3.8 && \
    apt-get install -y python3-pip

# ホームディレクトリの作成
RUN mkdir /root/dic

# ローカルPCのフォルダと結びつける
VOLUME ["/root/dic"]

# Python 3.8.10の設定
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1

CMD ["/bin/bash"]