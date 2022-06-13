# syntax=docker/dockerfile:experimental
FROM node:16.15.1-bullseye
RUN set -xe \
    && apt-get update \
    && apt-get -y install git openssh-client python3 make g++ tzdata \
    && git --version && bash --version && ssh -V && npm -v && node -v && yarn -v \
    && mkdir /var/lib/SoftwareGroup && chown -R node:node /var/lib/SoftwareGroup
WORKDIR /app
RUN chown -R node:node .
USER node
COPY --chown=node:node node/* .
RUN --mount=type=cache,target=/tmp/app/.npm,mode=0777,uid=1000,gid=1000 \
    set -xe \
    && npm set cache /tmp/app/.npm \
    && npm install
