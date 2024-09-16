# Build stage
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /workspace/app

# Copy gradle files
COPY gradlew .
COPY gradle gradle
COPY app/build.gradle.kts .

# Copy source code
COPY app/src src

# Build the application
RUN ./gradlew shadowJar --no-daemon

# Runtime stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy the built artifact from the build stage
COPY --from=build /workspace/app/build/libs/lichess.jar /app/lichess.jar

# Ensure access to the /tmp directory
VOLUME /tmp

# Set the entrypoint
ENTRYPOINT ["java", "-jar", "/app/lichess.jar"]
