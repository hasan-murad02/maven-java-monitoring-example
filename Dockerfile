FROM maven:3.8.4-openjdk-11 as baseImage
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

FROM openjdk:11-slim
WORKDIR /app
COPY --from=baseImage /app/target/*.jar ./app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]