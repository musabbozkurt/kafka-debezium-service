### Prerequisites

* Docker should be installed
* Java 21 should be installed --> `export JAVA_HOME=$(/usr/libexec/java_home -v 21)`

-----

### `docker-compose` contains the followings

* `Zookeeper`: http://localhost:2181
* `Kafka Nodes`: http://localhost:9092,http://localhost:9093
* `Kafdrop`, a UI tool to visualize topics and messages on: http://localhost:9000
* `PostgreSQL` DB connection details
    * `User: postgres`
    * `Password: postgres`
    * `Database: postgres`
    * `Port: 5433`

-----

### How to start the application

* First way
    * Run the following script --> [./scripts/run.sh](scripts%2Frun.sh)
* Second way
    * Run `docker-compose up -d` command to start the services `(OPTIONAL)`
    * Run `mvn clean install` or `mvn clean package`
    * Run `mvn spring-boot:run` or `./mvnw spring-boot:run`
* Third way
    * Run the following
      test --> [KafkaDebeziumServiceApplicationTests.java](src%2Ftest%2Fjava%2Fcom%2Fmb%2Fkafkadebeziumservice%2FKafkaDebeziumServiceApplicationTests.java)

-----

### Check and Test REST APIs via Swagger and Actuator

* Swagger Url: http://localhost:8001/swagger-ui/index.html
* Actuator Url: http://localhost:8001/actuator

-----

### How to test Debezium

* Connect to `PostgreSQL` with the provided connection details above
* Run the following query to make sure there are records

  ```sql
  
  select *
  from inventory.customers;
  
  ```
* Run the following script to update a record

  ```sql

  UPDATE inventory.customers
  SET email = 'sally.thomas.updated@acme.com'
  WHERE id = 1001;

  ```

* Check [Orders Inventory Customers Topic](http://localhost:9000/topic/orders.inventory.customers) to make sure message
  is published

-----

### Reference Documentation

For further reference, please consider the following sections:

* [Kafka Local](https://developer.confluent.io/quickstart/kafka-local/)
* [Run Debezium Kafka Connect using Docker | Kafka | Zookeeper | Kafdrop | Docker Compose](https://www.youtube.com/watch?v=yZy4QZYMUrY)
* [Debezium connector for PostgreSQL](https://debezium.io/documentation/reference/stable/connectors/postgresql.html)
* [Setting Up a Local Kafka Using Testcontainers in Spring Boot](https://medium.com/@truongbui95/setting-up-a-local-kafka-using-testcontainers-in-spring-boot-bb41466751e6)
* [Posting Request Body with Curl [Curl/Bash Code]](https://reqbin.com/req/curl/c-d2nzjn3z/curl-post-body)

-----