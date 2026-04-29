#!/bin/bash

set -e

echo "🚀 Deploy cluster Ozone..."

NAMESPACE="ozone-cluster"
PERCORSO_CORRENTE=$(pwd)


echo "📦 Creazione namespace..."
kubectl apply -f $PERCORSO_CORRENTE/k8s/namespace.yaml

echo "⚙️ ConfigMap..."
kubectl apply -f $PERCORSO_CORRENTE/k8s/config/ozone-config.yaml

echo "🧠 SCM..."
kubectl apply -f $PERCORSO_CORRENTE/k8s/scm/deployment.yaml
kubectl apply -f $PERCORSO_CORRENTE/k8s/scm/service.yaml

echo "🧾 OM..."
kubectl apply -f $PERCORSO_CORRENTE/k8s/om/deployment.yaml
kubectl apply -f $PERCORSO_CORRENTE/k8s/om/service.yaml

echo "💾 DataNode..."
kubectl apply -f $PERCORSO_CORRENTE/k8s/datanode/deployment.yaml
kubectl apply -f $PERCORSO_CORRENTE/k8s/datanode/service.yaml

echo "🌐 S3 Gateway..."
kubectl apply -f $PERCORSO_CORRENTE/k8s/s3g/deployment.yaml
kubectl apply -f $PERCORSO_CORRENTE/k8s/s3g/service.yaml

echo "🔌 API..."
kubectl apply -f $PERCORSO_CORRENTE/k8s/api/deployment.yaml
kubectl apply -f $PERCORSO_CORRENTE/k8s/api/service.yaml

echo "⏳ Attendo che i pod siano pronti..."
kubectl wait --for=condition=ready pod -l app=scm -n $NAMESPACE --timeout=180s
kubectl wait --for=condition=ready pod -l app=om -n $NAMESPACE --timeout=180s
kubectl wait --for=condition=ready pod -l app=datanode -n $NAMESPACE --timeout=180s
kubectl wait --for=condition=ready pod -l app=s3g -n $NAMESPACE --timeout=180s
kubectl wait --for=condition=ready pod -l app=api -n $NAMESPACE --timeout=180s

echo "✅ Deploy completato!"