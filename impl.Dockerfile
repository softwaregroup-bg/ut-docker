# syntax=docker/dockerfile:experimental
FROM nexus-dev.softwaregroup.com:5001/softwaregroup/ut-gallium-global:latest
COPY --chown=node:node impl/package.json package.json
RUN --mount=type=cache,target=/usr/src/app/.npm,mode=0777 \
    set -xe \
    && npm --legacy-peer-deps --registry https://nexus.softwaregroup.com/repository/npm-all/ install
