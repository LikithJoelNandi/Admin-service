FROM openjdk:8-jdk-alpine
RUN mkdir -p /usr/app
COPY ./admin-service-1.0.0-SNAPSHOT-exec.jar /usr/app
WORKDIR /usr/app
EXPOSE 8888
ENTRYPOINT ["java", "-jar", "admin-service-1.0.0-SNAPSHOT-exec.jar"]
