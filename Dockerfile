# Use a base image with Java and Maven installed
FROM maven:3.8.7-eclipse-temurin-17 AS build 

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml .
COPY src ./src

# Package the application using Maven (create a JAR file)
RUN mvn clean install

# Use a lightweight JRE for running the application
FROM eclipse-temurin:17-jre-focal

# Set the working directory inside the container for the JAR file
WORKDIR /app

# Copy the built JAR file from the previous step
COPY --from=build /app/target/spring-petclinic-*.jar ./app.jar

# Expose port 8080
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
