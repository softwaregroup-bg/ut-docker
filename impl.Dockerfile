FROM node:14.16.1-alpine
RUN set -xe \
    && apk add --no-cache bash git openssh python make g++ \
    && git --version && bash --version && ssh -V && npm -v && node -v && yarn -v \
    && mkdir /var/lib/SoftwareGroup && chown -R node:node /var/lib/SoftwareGroup
WORKDIR /app
RUN chown -R node:node .
USER node
COPY --chown=node:node impl/package.json package.json
RUN npm --production=false install
