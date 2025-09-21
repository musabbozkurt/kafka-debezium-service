#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/common.sh

export BASE_SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "BASE_SCRIPTS_DIR: $BASE_SCRIPTS_DIR"

echo "Current JAVA_HOME: $JAVA_HOME"

export JAVA_HOME=$(/usr/libexec/java_home -v 21)
echo "Current JAVA_HOME after export: $JAVA_HOME"

export CLUSTER_ID=$(docker run --rm confluentinc/cp-kafka:8.0.0 kafka-storage random-uuid)
echo "Generated CLUSTER_ID: $CLUSTER_ID"

docker-compose down -v
docker-compose up -d

echo "Waiting for services to be ready..."
sleep 10

# Check available connector plugins:
echo "Checking available connector plugins..."
curl -s -X GET -H 'Content-Type: application/json' http://localhost:8083/connector-plugins | jq '.'

postgres_connector=$(createPostgresConnector)
echo "create Postgres Connector: $postgres_connector"

./mvnw clean install
echo "mvn is run..."

./mvnw spring-boot:run
echo "App is started..."
