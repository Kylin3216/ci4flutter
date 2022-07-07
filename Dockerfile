FROM cirrusci/flutter:2.10.5

RUN flutter create --platform android test \
    && cd test && flutter build apk \
    && cd .. && rm -rf test

CMD ["bash"]
