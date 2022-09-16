FROM cirrusci/flutter:3.3.0

RUN flutter create --platform android test \
    && cd test && flutter build apk \
    && cd .. && rm -rf test

CMD ["bash"]
