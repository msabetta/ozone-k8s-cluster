import os

S3_ENDPOINT = os.getenv("S3_ENDPOINT", "http://s3g:9878")
S3_ACCESS_KEY = os.getenv("S3_ACCESS_KEY", "admin")
S3_SECRET_KEY = os.getenv("S3_SECRET_KEY", "password")
S3_BUCKET = os.getenv("S3_BUCKET", "iot-data")
NAMESPACE = os.getenv("NAMESPACE", "ozone-cluster")
API_PORT = int(os.getenv("API_PORT", "8000"))
API_HOST = os.getenv("API_HOST", "localhost")
KAFKA_BOOTSTRAP_SERVERS = os.getenv("KAFKA_BOOTSTRAP_SERVERS", "kafka:9092")
KAFKA_TOPIC = os.getenv("KAFKA_TOPIC", "iot-data")
DOCKER_IMAGE = os.getenv("DOCKER_IMAGE", "ozone-api")
DOCKER_TAG = os.getenv("DOCKER_TAG", "latest")
TIMEOUT = os.getenv("TIMEOUT", "180s")