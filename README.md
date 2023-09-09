### Prerequisites

* Docker should be installed
* Java 17+ should be installed
* pgAdmin/DBeaver can be installed (Optional)
* Postman can be installed (Optional)

### `docker-compose` contains the followings

* Zookeeper: ```http://localhost:2181```
* Kafka Nodes: ```http://localhost:9092```,```http://localhost:9093```
* Kafdrop, a UI tool to visualize topics and messages on: `http://localhost:9000/`
* PostgreSQL DB connection details
    * `POSTGRES_USER: postgres`
    * `POSTGRES_PASSWORD: postgres`
    * `Port: 5433`

### How to start the application

* First way
    * Run the following script --> [./scripts/run.sh](scripts%2Frun.sh)
* Second way
    * Run the following command to start the services --> ```docker-compose up -d```
    * Run the following command to use Java 17 (Or any java version installed on your system which should be
      17+) --> `export JAVA_HOME=$(/usr/libexec/java_home -v 17)`
    * Run `mvn clean install` or `mvn clean package`
    * Run `mvn spring-boot:run` or `./mvnw spring-boot:run`
* Third way
    * Run the following
      test --> [KafkaDebeziumServiceApplicationTests.java](src%2Ftest%2Fjava%2Fcom%2Fmb%2Fkafkadebeziumservice%2FKafkaDebeziumServiceApplicationTests.java)

### Swagger and Actuator

* Swagger Url: http://localhost:8001/swagger-ui/index.html
* Actuator Url: http://localhost:8001/actuator

### The following REST APIs can be tested via Swagger

* GET ```http://localhost:8001/producer```         --> check health of producer
* GET ```http://localhost:8001/consumer```         --> check health of consumer
* GET ```http://localhost:8001/consumer/orders```  --> retrieve List of unprocessed messages from orders topic
* POST ```http://localhost:8001/producer/orders``` --> publish messages

    ``` 
    curl -X 'POST' \
      'http://localhost:8001/producer/orders' \
      -H 'accept: */*' \
      -H 'Content-Type: application/json' \
      -d '"hello world"'
    ```

### How to test Debezium

* Connect to PostgreSQL with the following connection details
    * `POSTGRES_USER: postgres`
    * `POSTGRES_PASSWORD: postgres`
    * `Port: 5433`
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

### Reference Documentation

For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/3.1.3/maven-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/3.1.3/maven-plugin/reference/html/#build-image)
* [Spring Web](https://docs.spring.io/spring-boot/docs/3.1.3/reference/htmlsingle/index.html#web)
* [Spring for Apache Kafka](https://docs.spring.io/spring-boot/docs/3.1.3/reference/htmlsingle/index.html#messaging.kafka)
* [Kafka Local](https://developer.confluent.io/quickstart/kafka-local/)
* [Run Debezium Kafka Connect using Docker | Kafka | Zookeeper | Kafdrop | Docker Compose](https://www.youtube.com/watch?v=yZy4QZYMUrY)
* [Debezium connector for PostgreSQL](https://debezium.io/documentation/reference/stable/connectors/postgresql.html)
* [Setting Up a Local Kafka Using Testcontainers in Spring Boot](https://medium.com/@truongbui95/setting-up-a-local-kafka-using-testcontainers-in-spring-boot-bb41466751e6)
* [Posting Request Body with Curl [Curl/Bash Code]](https://reqbin.com/req/curl/c-d2nzjn3z/curl-post-body)

### Guides

The following guides illustrate how to use some features concretely:

* [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
* [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
* [Building REST services with Spring](https://spring.io/guides/tutorials/rest/)]