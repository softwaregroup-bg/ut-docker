FROM alpine:3.15.0

RUN apk update \
  && apk add --upgrade sipp ffmpeg
WORKDIR /scenarios
VOLUME ["/scenarios"]
