FROM node:16.14.2-bullseye
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN set -xe \
    && apt-get update \
    && apt-get -y install git openssh-client python3 make g++ tzdata \
        libglib2.0-0 libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 \
        libcups2 libdrm2 libdbus-1-3 libxcb1 libxkbcommon0 libx11-6 \
        libxcomposite1 libxdamage1 libxext6 libxfixes3 libxrandr2 \
        libgbm1 libpango-1.0-0 libcairo2 libasound2 libatspi2.0-0 \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18 \
    && sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/g' /etc/ssl/openssl.cnf \
    && git --version && bash --version && ssh -V && npm -v && node -v && yarn -v \
    && mkdir /var/lib/SoftwareGroup && chown -R node:node /var/lib/SoftwareGroup
ENV PATH="$PATH:/opt/mssql-tools18/bin"
WORKDIR /app
RUN chown -R node:node .
USER node
COPY --chown=node:node ut/package.json package.json
RUN npm --production=false --legacy-peer-deps --registry https://nexus.softwaregroup.com/repository/npm-all/ install \
    && npx playwright install chromium \
    && npm cache clean --force
