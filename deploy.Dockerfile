# syntax=docker/dockerfile:experimental
FROM node:16.19.0-bullseye-slim
RUN set -xe \
    && apt-get update \
    && apt-get -y install curl gnupg \
    && (curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list) \
    && (curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -) \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get -y install tzdata \
        libglib2.0-0 libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 \
        libcups2 libdrm2 libdbus-1-3 libxcb1 libxkbcommon0 libx11-6 \
        libxcomposite1 libxdamage1 libxext6 libxfixes3 libxrandr2 \
        libgbm1 libpango-1.0-0 libcairo2 libasound2 libatspi2.0-0 libwayland-client0 \
        msodbcsql18 mssql-tools18 \
    && sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/g' /etc/ssl/openssl.cnf
ENV PATH="$PATH:/opt/mssql-tools18/bin"
COPY --chown=node:node --from=nexus-dev.softwaregroup.com:5001/softwaregroup/ut-gallium:latest /home/node/.cache/ms-playwright /home/node/.cache/ms-playwright
