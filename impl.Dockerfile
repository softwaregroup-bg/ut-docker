# syntax=docker/dockerfile:experimental
FROM nexus-dev.softwaregroup.com:5001/softwaregroup/ut-gallium:latest
COPY --chown=node:node impl/package.json package.json
RUN --mount=type=cache,target=/home/node/.npm,mode=0777,uid=1000,gid=1000 \
    set -xe \
    && npm --legacy-peer-deps --registry https://nexus.softwaregroup.com/repository/npm-all/ install
