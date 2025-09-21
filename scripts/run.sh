#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/common.sh

export BASE_SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "BASE_SCRIPTS_DIR: $BASE_SCRIPTS_DIR"

echo "Current JAVA_HOME: $JAVA_HOME"

export JAVA_HOME=$(/usr/libexec/java_home -v 21)
echo "Current JAVA_HOME after export: $JAVA_HOME"

docker-compose down
docker-compose up -d

echo "Waiting for services to be ready..."
sleep 10

echo "Checking available connector plugins..."
curl -s -X GET -H 'Content-Type: application/json' http://localhost:8083/connector-plugins | jq '.'

postgres_connector=$(createPostgresConnector)
echo "create Postgres Connector: $postgres_connector"

oracle_connector=$(createOracleConnector)
echo "create Oracle Connector: $oracle_connector"

./mvnw clean install
echo "mvn is run..."

./mvnw spring-boot:run
