FROM alpine:3.15.0

RUN apk update \
  && apk add --upgrade sipp
WORKDIR /scenarios
VOLUME ["/scenarios"]
