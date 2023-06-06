# syntax=docker/dockerfile:experimental
FROM node:16.19.0-bullseye
RUN --mount=type=cache,target=/root/.npm,mode=0777 \
    set -xe \
    && apt-get update \
    && apt-get -y install git openssh-client python3 make g++ tzdata \
    && git --version && bash --version && ssh -V && npm -v && node -v && yarn -v \
    && mkdir /var/lib/SoftwareGroup && chown -R node:node /var/lib/SoftwareGroup \
    && mkdir /home/node/.npm && chown -R node:node /home/node/.npm \
    && npm set cache /root/.npm \
    && npm i --location=global ut-tools@^7.6.0
WORKDIR /app
RUN chown -R node:node .
USER node
COPY --chown=node:node node/* .
RUN --mount=type=cache,target=/home/node/.npm,mode=0777,uid=1000,gid=1000 \
    set -xe \
    && npm set cache /home/node/.npm \
    && npm install
