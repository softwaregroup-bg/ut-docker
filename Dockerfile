FROM risingstack/alpine:3.4-v6.7.0-4.0.0
RUN apk --update add openjdk8-jre
ENV SONAR_SCANNER_VERSION 2.8

RUN apk add --no-cache wget && \  
    wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-${SONAR_SCANNER_VERSION}.zip && \  
    unzip sonar-scanner-${SONAR_SCANNER_VERSION} && \  
    cd /usr/bin && ln -s /usr/src/node-app/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner sonar-scanner && \  
    apk del wget

COPY sonar-scanner-run.sh /usr/bin
COPY sonar-project.properties /usr/src/node-app/sonar-scanner-2.8/conf/sonar-scanner.properties
COPY package.json package.json
RUN npm install --registry=http://192.168.133.181:18081/repository/npm-all
