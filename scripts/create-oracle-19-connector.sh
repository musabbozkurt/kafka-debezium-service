#!/bin/bash

docker exec oracle-db-19 bash -c "
  cd /opt/oracle/oradata/ && mkdir -p recovery_area &&
  cd /opt/oracle/scripts/ && chmod +x 01-setup-debezium.sh && ./01-setup-debezium.sh &&
  sqlplus debezium/dbz@//localhost:1521/ORCLPDB1 @/opt/oracle/scripts/02-init.sql &&
  chmod +x 03-create-oracle-19-connector.sh && ./03-create-oracle-19-connector.sh
"

echo "Checking available connector plugins..."
curl -s -X GET -H 'Content-Type: application/json' http://localhost:8083/connector-plugins | jq '.'

oracle_19_connector=$(curl --location 'http://localhost:8083/connectors' \
                      --header 'Content-Type: application/json' \
                      --data '{
                          "name": "oracle-db-19-connector",
                          "config": {
                              "connector.class": "io.debezium.connector.oracle.OracleConnector",
                              "tasks.max": "1",
                              "database.server.name": "oracle-db-19-server",
                              "database.user": "c##dbzuser",
                              "database.password": "dbz",
                              "database.hostname": "oracle-db-19",
                              "database.port": "1521",
                              "database.dbname": "ORCLCDB",
                              "database.pdb.name": "ORCLPDB1",
                              "database.connection.adapter": "logminer",
                              "schema.history.internal.kafka.bootstrap.servers": "kafka1:29092,kafka2:29092,kafka3:29092",
                              "schema.history.internal.kafka.topic": "oracle-19-schema-history",
                              "topic.prefix": "oracle-db-19-server",
                              "table.include.list": "DEBEZIUM.CUSTOMERS,DEBEZIUM.ORDERS",
                              "include.schema.changes": "true",
                              "snapshot.mode": "initial",
                              "log.mining.strategy": "online_catalog",
                              "log.mining.continuous.mine": "true"
                          }
                      }')

echo "create Oracle 19 Connector: $oracle_19_connector"
