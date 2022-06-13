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
COPY --chown=node:node node/package.json package.json
RUN --mount=type=cache,target=/usr/src/app/.npm \
    set -xe \
    && npm set cache /usr/src/app/.npm \
    && npm --registry https://nexus.softwaregroup.com/repository/npm-all/ install
