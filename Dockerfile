# Stage 1: Build the application using Maven
FROM maven:3.8.5-openjdk-11 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build WAR file
RUN mvn clean package

# Stage 2: Run the application using Tomcat
FROM tomcat:9.0-jdk11-openjdk

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built WAR to Tomcat webapps as ROOT
COPY --from=build /app/target/VPNProject.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
