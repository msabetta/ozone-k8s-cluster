import os

S3_ENDPOINT = os.getenv("S3_ENDPOINT", "http://s3g:9878")
S3_ACCESS_KEY = os.getenv("S3_ACCESS_KEY", "admin")
S3_SECRET_KEY = os.getenv("S3_SECRET_KEY", "password")
S3_BUCKET = os.getenv("S3_BUCKET", "iot-data")