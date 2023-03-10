#
# Build stage
#

FROM maven:3.8-eclipse-temurin-17-alpine AS build

WORKDIR usr/src/app

COPY . ./

RUN mvn clean package

#
# Package stage
#

FROM openjdk:17-alpine

ARG JAR_NAME="test_spring_github_azure-0.0.1-SNAPSHOT"

WORKDIR /usr/src/app



COPY --from=build /usr/src/app/target/${JAR_NAME}.jar ./app.jar

CMD ["java","-jar", "./app.jar"]