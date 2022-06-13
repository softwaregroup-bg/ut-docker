# syntax=docker/dockerfile:experimental
FROM node:10.1.0-alpine
RUN npm install localtunnel-server && \
    cp -r `find . -name "localtunnel-server"` /app
WORKDIR /app
ENV NODE_ENV production
ENTRYPOINT ["node", "-r", "esm", "/app/bin/server"]
