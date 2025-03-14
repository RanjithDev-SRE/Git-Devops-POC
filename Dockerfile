# Use an official Maven image to build the project
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK image to run the application
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy the built JAR file from the Maven build stage
COPY --from=build /app/target/javaparser-maven-sample-1.0-SNAPSHOT-shaded.jar app.jar

# Expose the port (if applicable)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
