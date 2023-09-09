#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/common.sh

export BASE_SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "BASE_SCRIPTS_DIR: $BASE_SCRIPTS_DIR"

echo "Current JAVA_HOME: $JAVA_HOME"

# docker-compose -f docker-compose.yml down
# echo "docker-compose down is run..."

docker-compose -f docker-compose.yml up -d
echo "docker-compose up is run..."
logInfo "docker-compose up is run test..."

export JAVA_HOME=$(/usr/libexec/java_home -v 17)
echo "Current JAVA_HOME after export: $JAVA_HOME"

sleep 10

inventory_connector=$(createDebeziumConnectors2)
echo "create debezium connectors response: $inventory_connector"

mvn clean install
echo "mvn is run..."

# mvn spring-boot:run
./mvnw spring-boot:run
echo "App is started..."