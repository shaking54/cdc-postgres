#!/bin/bash

# Kafka bootstrap server
BOOTSTRAP_SERVER="kafka:9092"

# Function to create a Kafka topic
create_topic() {
  TOPIC_NAME=$1
  PARTITIONS=$2
  REPLICATION_FACTOR=$3

  kafka-topics --create \
    --bootstrap-server $BOOTSTRAP_SERVER \
    --replication-factor $REPLICATION_FACTOR \
    --partitions $PARTITIONS \
    --topic $TOPIC_NAME || echo "Topic $TOPIC_NAME might already exist."
}

create_topic_config() {
  TOPIC_NAME=$1
  PARTITIONS=$2
  REPLICATION_FACTOR=$3

  kafka-topics --create \
    --bootstrap-server $BOOTSTRAP_SERVER \
    --replication-factor $REPLICATION_FACTOR \
    --partitions $PARTITIONS \
    --topic $TOPIC_NAME || echo "Topic $TOPIC_NAME might already exist." \
    --config cleanup.policy=compact
}

# Create topics
create_topic "cdc_orders" 1 1
create_topic "cdc_customers" 1 1
create_topic "alerts" 1 1
create_topic_config "debezium_configs" 5 1
create_topic_config "debezium_offsets" 5 1
create_topic_config "debezium_status" 5 1

# List created topics
kafka-topics --list --bootstrap-server $BOOTSTRAP_SERVER
