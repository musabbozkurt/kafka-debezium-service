### Prerequisites

- Docker should be installed
- Java 21 should be installed --> `export JAVA_HOME=$(/usr/libexec/java_home -v 21)`

-----

### `docker-compose` contains the followings

- `PostgreSQL` DB connection details
    - `User: postgres`
    - `Password: postgres`
    - `Database: postgres`
    - `Port: 5433`
- `Oracle PDB (Pluggable Database)` DB connection details
    - `Host: localhost`
    - `Service: freepdb1`
    - `Port: 1521`
    - Login:
        - Authentication: `SYSDBA`
            - `User: SYS`
            - `Password: oracle_password`
        - Authentication: `User & Password`
            - `User: MB_ORACLE_USER`
            - `Password: oracle_password`

- `Kafka Nodes`: http://localhost:8080/ui/clusters/local/brokers
- `kafka-ui`: http://localhost:8080
- `debezium-connectors`: http://localhost:8083/connectors

-----

### How to start the application

- Run [./scripts/run.sh](scripts%2Frun.sh) command to start the application

-----

### Check and Test REST APIs via Swagger and Actuator

- Swagger Url: http://localhost:8001/swagger-ui/index.html
- Actuator Url: http://localhost:8001/actuator

-----

### How to test Debezium

- Connect to `PostgreSQL` with the provided connection details above
- Run the following query to make sure there are records

  ```sql
  
  select *
  from inventory.customers;
  
  ```
- Run the following script to update a record

  ```sql

  UPDATE inventory.customers
  SET email = 'sally.thomas.updated@acme.com'
  WHERE id = 1001;

  ```

- Check [inventory-db-server.inventory.customers topic](http://localhost:8080/ui/clusters/local/all-topics?perPage=25)
  to make sure message is published

-----

### Reference Documentation

For further reference, please consider the following sections:

- [Debezium Source Connectors](https://debezium.io/documentation/reference/stable/connectors/index.html)
- [Setting Up a Kafka Cluster Using Docker Compose(Kraft Mode): A Step-by-Step Guide](https://medium.com/@darshak.kachchhi/setting-up-a-kafka-cluster-using-docker-compose-a-step-by-step-guide-a1ee5972b122)
- [Posting Request Body with Curl [Curl/Bash Code]](https://reqbin.com/req/curl/c-d2nzjn3z/curl-post-body)

-----
