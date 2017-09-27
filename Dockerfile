FROM java:openjdk-8-jdk-alpine

COPY . /SparkKotlinDocker

RUN apk update && \ 
    apk add --virtual build-dependencies build-base bash curl && \
    cd /SparkKotlinDocker && ./gradlew clean && \
    cd /SparkKotlinDocker && ./gradlew build && \
    mkdir -p /usr/local/SparkKotlinDocker/lib && \
    cp -R /SparkKotlinDocker/build/libs/* /usr/local/SparkKotlinDocker/lib/ && \
    curl -o /usr/local/SparkKotlinDocker/lib/jolokia-jvm-agent.jar https://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.5/jolokia-jvm-1.3.5-agent.jar && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    rm -rf ~/.gradle && \
    rm -rf /SparkKotlinDocker

ENTRYPOINT java $JAVA_OPTS -javaagent:/usr/local/SparkKotlinDocker/lib/jolokia-jvm-agent.jar=port=8778,host=0.0.0.0 -jar /usr/local/SparkKotlinDocker/lib/SparkKotlinDocker.jar

EXPOSE 4567 8778 
