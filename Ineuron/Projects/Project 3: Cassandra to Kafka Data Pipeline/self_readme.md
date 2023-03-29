# Project 3: Cassandra to Kafka Data Pipeline

1:30:00 --> for project improvement

## Pre-requisite to begin with Project
<p>Add these below extension in VS Code

- Python
- Dev Containers
- Remote Development
- Cassandra Workbench
    - To active the workbench, read the description of Extension

</p>

## Step 1 - Execute Docker-compose.yml file
<p>Commands used in this step

- docker compose -f docker-compose.yml up -d
    - to execute the docker-compose.yml file to run the required containers
    - While running this cmd, I was getting the "Error response from daemon: invalid volume specification". So I have removed the Volume variable in yml
- docker ps
    - to check the running containers
</p>

## Step 2 - Cassandra Workbench

- cmd + shift + p # This is will open pallet, type ">cassandra Workbench: Generate configuration" and select it. This will open a file with name .cassandraWorkbench.jsonc. Open this file and enter the password and username. Then save it.
- Goto Cassandra Wkbch and click CQL icon on the top. This is open a query file and execute the below command:
    * Create a keysapce with name "ineuron"
        ```
        CREATE KEYSPACE ineuron
            WITH REPLICATION = {
                'class': 'org.apache.cassandra.locator.SimpleStrategy',
                'replication_factor': '3'
            }
            AND DURABLE_WRITES = true;
        ```
    
    * Create a table Employee
        ```
        CREATE TABLE ineuron.EMPLOYEE(
            EMP_ID INT,
            EMP_NAME text,
            CITY text,
            STATE text,
            primary key (EMP_ID)
        );
        ```
    * Insert the data in Employee Table
        - Run the cmd from CQL_SCRIPT.cql file.

## Step 3: Streaming with Kakfa

<p>In this step, we will work with Kafka to read the data from Cassandra and write it to configured location</p>

1. cmd + shift + p # type dev containers: attach to running container and select it. this will open a new window.
2. type ls / in terminal and select project folder
