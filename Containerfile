FROM clojure as builder
WORKDIR /usr/src/app
COPY . .
RUN clj -T:build ci

FROM eclipse-temurin
WORKDIR /usr/src/app
CMD ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=85", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseZGC", "-jar", "app.jar"]
COPY --from=builder /usr/src/app/target/*.jar app.jar
