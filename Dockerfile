FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]

# Stage 1: assume you build locally, so use a plain Tomcat base
FROM tomcat:9.0-jdk11
# Remove the default webapps/ROOT
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy the WAR built by your Maven into Tomcat webapps as ROOT.war
COPY target/FoodSystem.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
