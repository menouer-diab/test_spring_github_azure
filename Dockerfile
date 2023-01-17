#
# Build stage
#

FROM maven:3.8.3-openjdk-17 AS build

WORKDIR usr/src/app

COPY . ./

RUN mvn clean package

#
# Package stage
#

FROM openjdk:17-alpine

ARG JAR_NAME="test_spring_github_azure"

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/target/${JAR_NAME}.jar ./app.jar

CMD ["java","-jar", "./app.jar"]