#!/bin/bash

set -e

echo "🚀 Deploy cluster Ozone..."

NAMESPACE="ozone-cluster"

echo "📦 Creazione namespace..."
kubectl apply -f k8s/namespace.yaml

echo "⚙️ ConfigMap..."
kubectl apply -f k8s/config/

echo "🧠 SCM..."
kubectl apply -f k8s/scm/

echo "🧾 OM..."
kubectl apply -f k8s/om/

echo "💾 DataNode..."
kubectl apply -f k8s/datanode/

echo "🌐 S3 Gateway..."
kubectl apply -f k8s/s3g/

echo "🔌 API..."
kubectl apply -f k8s/api/

echo "⏳ Attendo che i pod siano pronti..."
kubectl wait --for=condition=ready pod -l app=scm -n $NAMESPACE --timeout=180s
kubectl wait --for=condition=ready pod -l app=om -n $NAMESPACE --timeout=180s
kubectl wait --for=condition=ready pod -l app=datanode -n $NAMESPACE --timeout=180s

echo "✅ Deploy completato!"