FROM node:14.15.3-alpine
RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      freetype-dev \
      harfbuzz \
      ca-certificates \
      ttf-freefont
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
WORKDIR /app
RUN chown -R node:node .
USER node
RUN npm install capture-website-cli
ENTRYPOINT ["/app/node_modules/.bin/capture-website"]
