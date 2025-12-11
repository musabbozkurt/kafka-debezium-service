FROM openjdk:25-rc-slim
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} kafka-debezium-service.jar
ENTRYPOINT ["java","-jar","/kafka-debezium-service.jar"]
