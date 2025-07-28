# Start from Red Hat Universal Base Image with Java 17
FROM registry.access.redhat.com/ubi8/openjdk-17:latest
# Set working directory inside the container
WORKDIR /workdir
# Copy the JAR built by Maven
COPY target/petclinic-0.0.1-SNAPSHOT.jar app.jar
# Expose port 8080
EXPOSE 8080
# Run the application
CMD ["java","-jar","app.jar"]
