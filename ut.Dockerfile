FROM node:14.19.0-alpine
RUN set -xe \
    && apk add --no-cache bash git openssh python3 make g++ chromium harfbuzz nss freetype ttf-freefont font-noto-emoji \
    && git --version && bash --version && ssh -V && npm -v && node -v && yarn -v \
    && mkdir /var/lib/SoftwareGroup && chown -R node:node /var/lib/SoftwareGroup
WORKDIR /app
RUN chown -R node:node .
USER node
COPY --chown=node:node ut/package.json package.json
RUN npm --production=false install
