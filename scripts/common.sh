#!/bin/bash

# Logging
function me {
    basename $0
}

function timestamp {
  date +"%F %T"
}

function fail {
    echo -e "\033[0;31m[$(me) - $(timestamp)][FAIL] $*\033[0m"
    exit 1
}

function logInfo {
    echo -e "\033[0;32m[$(me) - $(timestamp)][INFO] $*\033[0m"
}

function logWarn {
    echo -e "\033[1;33m[$(me) - $(timestamp)][WARN] $*\033[0m"
}

function randomPort {
    echo -n $(( ( RANDOM % 60000 ) + 1024 ))
}

function createDebeziumConnectors {
    inventory_connector=$(curl -X POST 'http://localhost:8083/connectors' \
                                -H 'Content-Type: application/json' \
                                -d '{
                                       "name": "inventory-connector",
                                       "config": {
                                         "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
                                         "database.hostname": "postgres",
                                         "database.port": "5432",
                                         "database.user": "postgres",
                                         "database.password": "postgres",
                                         "database.dbname": "postgres",
                                         "database.server.name": "dbserver1",
                                         "table.include.list": "inventory.customers",
                                         "topic.prefix": "orders"
                                       }
                                     }')
        echo $inventory_connector
}

function createDebeziumConnectors2 {
    inventory_connector=$(curl --location 'http://localhost:8083/connectors' \
                          --header 'Content-Type: application/json' \
                          --data '{
                            "name": "inventory-connector",
                            "config": {
                              "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
                              "database.hostname": "postgres",
                              "database.port": "5432",
                              "database.user": "postgres",
                              "database.password": "postgres",
                              "database.dbname": "postgres",
                              "database.server.name": "dbserver1",
                              "table.include.list": "inventory.customers",
                              "topic.prefix": "orders"
                            }
                          }')
        echo $inventory_connector
}