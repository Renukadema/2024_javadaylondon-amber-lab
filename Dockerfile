# Use a Maven base image to build the application
FROM maven AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml ./
COPY src ./src

# Build the project
RUN mvn clean package

# Use a smaller OpenJDK runtime image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/2024_javadaylondon-amber-lab-1.0-SNAPSHOT.jar ./my-app.jar

# Expose the port the application will run on (adjust as needed)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "my-app.jar"]

