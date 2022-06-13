# syntax=docker/dockerfile:experimental
FROM nexus-dev.softwaregroup.com:5001/softwaregroup/ut-gallium-global:latest
COPY --chown=node:node impl/package.json package.json
RUN --mount=type=cache,target=/tmp/app/.npm,mode=0777,uid=1000,gid=1000 \
    set -xe \
    && npm --legacy-peer-deps install
