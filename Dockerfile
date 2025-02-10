# Use the official Maven image to build the application
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package

# Use the official OpenJDK image to run the application
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/my-java-app-1.0-SNAPSHOT.jar my-java-app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "my-java-app.jar"]
