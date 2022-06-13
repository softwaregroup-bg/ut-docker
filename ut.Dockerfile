# syntax=docker/dockerfile:experimental
FROM nexus-dev.softwaregroup.com:5001/softwaregroup/node-gallium-global:latest
USER root
RUN --mount=type=cache,target=/tmp/app/.npm,mode=0777,uid=1000,gid=1000 \
    set -xe \
    && (curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list) \
    && (curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -) \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get -y install \
        libglib2.0-0 libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 \
        libcups2 libdrm2 libdbus-1-3 libxcb1 libxkbcommon0 libx11-6 \
        libxcomposite1 libxdamage1 libxext6 libxfixes3 libxrandr2 \
        libgbm1 libpango-1.0-0 libcairo2 libasound2 libatspi2.0-0 \
        msodbcsql18 mssql-tools18 \
    && sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/g' /etc/ssl/openssl.cnf \
    && npm set cache /tmp/app/.npm \
    && npm i --location=global ut-tools@^7.1.5 ut-help@^1.1.13 ut-storybook@^8.0.1 ut-webpack@^8.0.2
ENV PATH="$PATH:/opt/mssql-tools18/bin"
USER node
COPY --chown=node:node ut/package.json package.json
RUN --mount=type=cache,target=/tmp/app/.npm,mode=0777,uid=1000,gid=1000 \
    set -xe \
    && npm --legacy-peer-deps --registry https://nexus.softwaregroup.com/repository/npm-all/ install
