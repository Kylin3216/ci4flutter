FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl file git zip xz-utils && apt-get clean

ENV FLUTTER_VERSION=3.3.0

WORKDIR /usr
RUN curl -O https://storage.flutter-io.cn/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz && \
    tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz && \
    rm -f flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

ENV PATH=$PATH:/usr/flutter/bin

RUN flutter precache && flutter doctor -v

CMD ["bash"]