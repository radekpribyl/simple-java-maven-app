FROM openjdk:11.0.5-jre-slim
ARG APPDIR=./target/
ARG APPNAME=app.jar
ENV ENVAPPNAME=$APPNAME
WORKDIR /usr/app
COPY $APPDIR* ./
ENTRYPOINT [ "java", "-jar", $ENVAPPNAME ]
