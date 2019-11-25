FROM openjdk:11.0.5-jre-slim
ARG APPDIR=./target/
ARG APPNAME=app.jar
WORKDIR /usr/app
COPY $APPDIR* ./
ENTRYPOINT [ "java", "-jar"]
CMD ["${APPNAME}"]
