#
# Copyright 2015-2016 The OpenZipkin Authors
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions and limitations under
# the License.
#
FROM openzipkin/jre-full:1.8.0_121
MAINTAINER OpenZipkin "http://zipkin.io/"

ENV ZIPKIN_REPO https://jcenter.bintray.com
ENV ZIPKIN_VERSION 1.26.1

# AppInsights settings
ENV JAVA_OPTS -Dloader.path=applicationinsights -Dspring.profiles.active=applicationinsights -Dlogging.level.zipkin=DEBUG

# Add environment settings for supported storage types
COPY zipkin/ /zipkin/

# copy already built binaries into zipkin folder
COPY applicationinsights/ /zipkin/applicationinsights

WORKDIR /zipkin

RUN apk add unzip && \
    curl -SL $ZIPKIN_REPO/io/zipkin/java/zipkin-server/$ZIPKIN_VERSION/zipkin-server-$ZIPKIN_VERSION-exec.jar > zipkin-server.jar && \
    unzip zipkin-server.jar && \
    rm zipkin-server.jar && \
    curl -SL $ZIPKIN_REPO/io/zipkin/java/zipkin-autoconfigure-collector-kafka10/$ZIPKIN_VERSION/zipkin-autoconfigure-collector-kafka10-$ZIPKIN_VERSION-module.jar > kafka10.jar && \
    unzip kafka10.jar -d kafka10 && \
    rm kafka10.jar && \
    apk del unzip

EXPOSE 9410 9411

CMD java ${JAVA_OPTS} -cp . org.springframework.boot.loader.PropertiesLauncher
