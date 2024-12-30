# OpenJDK 이미지 기반
FROM openjdk:17-jdk-slim

# 앱 디렉토리 설정
WORKDIR /app

# JAR 파일 복사
COPY build/libs/*.jar app.jar

# Spring Boot 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "/app.jar"]
