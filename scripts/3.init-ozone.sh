#!/bin/bash

set -e

echo "🔧 Inizializzazione Ozone..."

S3_ENDPOINT="http://localhost:9878"
BUCKET="iot-data"
AWS_ACCESS_KEY_ID="test"
AWS_SECRET_ACCESS_KEY="test"
AWS_DEFAULT_REGION="eu-south-1"
AWS_FORMAT="json"

aws configure set aws_access_key_id "$AWS_ACCESS_KEY"
aws configure set aws_secret_access_key "$AWS_SECRET_KEY"
aws configure set region "$AWS_REGION"
aws configure set output "$AWS_FORMAT"


# echo "🌐 Port-forward temporaneo..."
# kubectl port-forward svc/s3g 9878:9878 -n ozone-cluster > /dev/null 2>&1 &
# PF_PID=$!

# sleep 5

echo "📦 Creazione bucket: $BUCKET"
aws --endpoint-url=$S3_ENDPOINT s3 mb s3://$BUCKET || true

echo "📂 Verifica bucket..."
aws --endpoint-url=$S3_ENDPOINT s3 ls

# echo "🛑 Stop port-forward..."
# kill $PF_PID

echo "✅ Ozone inizializzato!"