FROM risingstack/alpine:3.4-v6.10.2-4.4.0
RUN apk --update add openjdk8-jre
ENV SONAR_SCANNER_VERSION 3.0.3.778

RUN apk add --no-cache wget && \
    wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION} && \
    cd /usr/bin && ln -s /usr/src/node-app/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner sonar-scanner && \
    apk del wget

COPY sonar-scanner-run.sh /usr/bin
COPY sonar-project.properties /usr/src/node-app/sonar-scanner-${SONAR_SCANNER_VERSION}/conf/sonar-scanner.properties
COPY package.json package.json
RUN npm install
