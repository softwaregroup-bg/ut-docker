FROM nexus-dev.softwaregroup.com:5001/softwaregroup/ut-gallium-global:latest
COPY --chown=node:node impl/package.json package.json
RUN npm --legacy-peer-deps --registry https://nexus.softwaregroup.com/repository/npm-all/ install \
    && npm cache clean --force
