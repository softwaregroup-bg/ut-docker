FROM risingstack/alpine:3.4-v6.7.0-4.0.0
COPY package.json package.json
RUN npm install
