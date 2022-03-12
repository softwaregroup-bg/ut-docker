FROM node:16.14.0
RUN set -xe \
    && apt install git openssh-client python3 make g++ \
    && git --version && bash --version && ssh -V && npm -v && node -v && yarn -v \
    && mkdir /var/lib/SoftwareGroup && chown -R node:node /var/lib/SoftwareGroup
WORKDIR /app
RUN chown -R node:node .
USER node
COPY --chown=node:node ut/package.json package.json
RUN npm --production=false --legacy-peer-deps install \
    && npx playwright install chromium \
    && npm cache clean --force
