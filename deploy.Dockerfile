FROM mhart/alpine-node:slim-14.16.1
RUN apk add --no-cache tzdata
RUN addgroup -S node && adduser -S -G node node && mkdir /var/lib/SoftwareGroup && chown -R node:node /var/lib/SoftwareGroup
USER node
COPY --chown=node:node --from=${UT_PROJECT}:$TAG /app /app
WORKDIR /app
COPY --chown=node:node dist dist
ENTRYPOINT ["node", "index.js"]
CMD ["server"]
