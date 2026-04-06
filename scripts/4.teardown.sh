#!/bin/bash

set -e

echo "💣 Rimozione cluster Ozone..."

NAMESPACE="ozone-cluster"

echo "🧹 Eliminazione risorse..."
kubectl delete -f k8s/api/ --ignore-not-found
kubectl delete -f k8s/s3g/ --ignore-not-found
kubectl delete -f k8s/datanode/ --ignore-not-found
kubectl delete -f k8s/om/ --ignore-not-found
kubectl delete -f k8s/scm/ --ignore-not-found
kubectl delete -f k8s/config/ --ignore-not-found

echo "📦 Eliminazione namespace..."
kubectl delete namespace $NAMESPACE --ignore-not-found

echo "🗑️ Cleanup PVC (ATTENZIONE: dati persi)"
kubectl delete pvc --all -n $NAMESPACE --ignore-not-found

echo "✅ Cluster rimosso!"