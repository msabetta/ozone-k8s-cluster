#!/bin/bash

echo "🔌 Avvio port-forward..."

NAMESPACE="ozone-cluster"

echo "🌐 S3 Gateway → localhost:9878"
kubectl port-forward svc/s3g 9878:9878 -n $NAMESPACE &

echo "🚀 API → localhost:8000"
kubectl port-forward svc/ozone-api 8000:80 -n $NAMESPACE &

echo "📊 Premi CTRL+C per fermare"

wait