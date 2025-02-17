# # 🚀🚀🚀 cdc-postgres

## 📢 Overview

`cdc-postgres` is a project designed to implement Change Data Capture (CDC) for PostgreSQL databases. It leverages tools like Kafka and Debezium to monitor and capture data changes in real-time, ensuring that downstream applications have access to the latest data.

This project is built with purpose snapshot a OLTP database and stream the changes to a OLAP database

## 📌 Features

- **Real-time Data Capture**: Monitors PostgreSQL databases for changes and captures INSERT, UPDATE, and DELETE operations as they occur.
- **Integration with Kafka**: Streams captured data changes into Kafka topics for further processing or integration with other systems.
- **Debezium Integration**: Utilizes Debezium connectors to handle the CDC process efficiently.

## ⚙️ Prerequisites

Before setting up the project, ensure you have the following installed:

- Docker
- Docker Compose

## 🚀 Setup Instructions

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/shaking54/cdc-postgres.git
   cd cdc-postgres
   ```

2. **Start the Services**:

   The project includes Docker Compose configurations for setting up the necessary services.

   - To start Kafka and Zookeeper:

     ```bash
     make kafka
     ```

   - To start Debezium:

     ```bash
     make connect
     ```


3. **Set Up Debezium Connector**:

   Configure Debezium to monitor your PostgreSQL database by sending a POST request to the Kafka Connect REST API. Replace placeholder values as needed.

   ```json
   {
     "name": "postgres-connector",
     "config": {
       "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
       "database.hostname": "[replace with your db host]",
       "database.port": "5432",
       "database.user": "[replace with your db user]",
       "database.password": "[replace with your db password]",
       "database.dbname": "[replace with your db name]",
       "database.server.name": "[replace with your server name]",
       "table.include.list": "[replace with you table name following format. seperate with commas: schema_name.table_name1, schema_name.table_name2]",
       "plugin.name": "pgoutput"
     }
   }
   ```

   You can use a tool like `curl` to send this configuration:

   ```bash
   curl -X POST -H "Content-Type: application/json" -d @connector-config.json http://localhost:8083/connectors
   ```

   Ensure that the `connector-config.json` file contains the JSON configuration shown above.

## 📊 Usage

Once set up, the system will capture changes from the specified PostgreSQL tables and stream them into the corresponding Kafka topics. You can then consume these topics using your preferred Kafka consumer to process the data changes.

##  🙌 Acknowledgments

- [Debezium](https://debezium.io/) for providing CDC connectors.
- [Apache Kafka](https://kafka.apache.org/) for the robust streaming platform.
- [Docker](https://www.docker.com/) for containerization.

