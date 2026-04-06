import boto3
from botocore.client import Config
from app.config import (
    S3_ENDPOINT,
    S3_ACCESS_KEY,
    S3_SECRET_KEY,
    S3_BUCKET
)

s3 = boto3.client(
    "s3",
    endpoint_url=S3_ENDPOINT,
    aws_access_key_id=S3_ACCESS_KEY,
    aws_secret_access_key=S3_SECRET_KEY,
    config=Config(signature_version="s3v4"),
    region_name="us-east-1"
)

def upload_file(name: str, data: bytes):
    s3.put_object(
        Bucket=S3_BUCKET,
        Key=name,
        Body=data
    )

def download_file(name: str) -> bytes:
    response = s3.get_object(
        Bucket=S3_BUCKET,
        Key=name
    )
    return response["Body"].read()