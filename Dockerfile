FROM alpine:latest

LABEL tech.dreamfund.image.authors="xiasuwan@gmail.com"
LABEL version="1.0"

ENV ANDROID_COMPILE_SDK=30
ENV ANDROID_BUILD_TOOLS=30.0.3 
ENV ANDROID_SDK_TOOLS=8512546
ENV FLUTTER_CHANNEL=stable
ENV FLUTTER_VERSION=2.10.5-${FLUTTER_CHANNEL}

RUN apk -U update && apk -U add \
    bash \
    libarchive-tools \
    ca-certificates \
    curl \
    expect \
    fontconfig \
    git \
    make \
    libstdc++ \
    libgcc \
    mesa-dev \
    openjdk11 \
    pulseaudio-dev \
    su-exec \
    ncurses \
    tar \
    xz \
    unzip \
    wget \
    zlib \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH=$PATH:/opt/android-sdk-linux/platform-tools/

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip \
    && unzip android-sdk.zip -d /opt/android-sdk-linux/ \
    && echo "y" | /opt/android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "platforms;android-${ANDROID_COMPILE_SDK}" \
    && echo "y" | /opt/android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "platform-tools" \
    && echo "y" | /opt/android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "build-tools;${ANDROID_BUILD_TOOLS}" \
    && yes | /opt/android-sdk-linux/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME --licenses || echo "Failed" \
    && rm android-sdk.zip

RUN wget --quiet --output-document=flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/{FLUTTER_CHANNEL}/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz \
    && tar xf flutter.tar.xz -C /opt \
    && rm flutter.tar.xz

ENV PATH=$PATH:/opt/flutter/bin

RUN yes | flutter doctor --android-licenses && flutter doctor 

CMD [ "bash" ]
