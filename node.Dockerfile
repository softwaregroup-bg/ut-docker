FROM node:16.15.0-bullseye
RUN set -xe \
    && apt-get update \
    && apt-get -y install git openssh-client python3 make g++ tzdata \
    && git --version && bash --version && ssh -V && npm -v && node -v && yarn -v \
    && mkdir /var/lib/SoftwareGroup && chown -R node:node /var/lib/SoftwareGroup
WORKDIR /app
RUN chown -R node:node .
USER node
COPY --chown=node:node node/package.json package.json
RUN npm --production=false --legacy-peer-deps --registry https://nexus.softwaregroup.com/repository/npm-all/ install \
    && npm cache clean --force
