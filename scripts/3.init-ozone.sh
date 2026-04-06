#!/bin/bash

set -e

echo "🔧 Inizializzazione Ozone..."

S3_ENDPOINT="http://localhost:9878"
BUCKET="iot-data"

echo "🌐 Port-forward temporaneo..."
kubectl port-forward svc/s3g 9878:9878 -n ozone-cluster > /dev/null 2>&1 &
PF_PID=$!

sleep 5

echo "📦 Creazione bucket: $BUCKET"
aws --endpoint-url=$S3_ENDPOINT s3 mb s3://$BUCKET || true

echo "📂 Verifica bucket..."
aws --endpoint-url=$S3_ENDPOINT s3 ls

echo "🛑 Stop port-forward..."
kill $PF_PID

echo "✅ Ozone inizializzato!"