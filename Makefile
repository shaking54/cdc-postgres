# Start all services
start: kafka connect

# Stop all services
stop:
	docker compose -f docker-compose.kafka.yml -f docker-compose.debezium.yml down

# Start Kafka & Zookeeper
kafka:
	docker compose -f docker-compose.kafka.yml up -d

# Start Kafka Connect
connect:
	docker compose -f docker-compose.debezium.yml up -d

# Clean up everything
clean:
	docker compose -f docker-compose.postgres.yml -f docker-compose.kafka.yml -f docker-compose.connect.yml down -v