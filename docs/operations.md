# ⚙️ Operations Guide

## 📌 Introduzione

Questa guida descrive le operazioni quotidiane per gestire il sistema basato su:

* Apache Ozone
* Kubernetes
* Apache Kafka

---

## 🚀 Deploy

### Deploy completo

```bash
make deploy
```

---

### Verifica stato

```bash
make status
```

---

## 🔌 Accesso servizi

### Port-forward

```bash
make port-forward
```

Servizi disponibili:

* API → http://localhost:8000
* S3 → http://localhost:9878

---

## 📦 Inizializzazione

```bash
make init
```

Crea:

* bucket Ozone
* struttura base

---

## 🧪 Test

```bash
make test
```

---

## 📊 Monitoraggio

### Stato pod

```bash
kubectl get pods -n ozone-cluster
```

---

### Log

```bash
make logs
```

---

### Debug pod

```bash
kubectl describe pod <pod> -n ozone-cluster
```

---

## 📈 Scaling

### DataNode

```bash
kubectl scale statefulset datanode --replicas=5 -n ozone-cluster
```

---

### API

```bash
kubectl scale deployment ozone-api --replicas=3 -n ozone-cluster
```

---

## 🔄 Rolling update

```bash
kubectl rollout restart deployment ozone-api -n ozone-cluster
```

---

## 🧹 Cleanup

```bash
make destroy
```

---

## ⚠️ Troubleshooting

### Pod in CrashLoop

```bash
kubectl logs <pod> -n ozone-cluster
```

---

### Kafka non disponibile

Verifica:

```bash
kubectl get pods -l app=kafka -n ozone-cluster
```

---

### S3 non raggiungibile

```bash
kubectl port-forward svc/s3g 9878:9878 -n ozone-cluster
```

---

### Bucket non esistente

```bash
make init
```

---

## 🔐 Sicurezza operativa

### Consigli

* non usare credenziali di default
* limitare accesso API
* usare network policies

---

## 💾 Backup

### Strategie

* snapshot PVC
* replica bucket
* export dati via S3

---

## 📊 Performance tuning

### Ozone

* aumentare DataNode
* SSD per metadata
* tuning replica

---

### Kafka

* aumentare partizioni
* batch size

---

### API

* async I/O
* load balancing

---

## 🔄 Manutenzione

### Restart servizi

```bash
kubectl rollout restart statefulset datanode -n ozone-cluster
```

---

### Upgrade immagini

```bash
kubectl set image deployment/ozone-api api=ozone-api:new -n ozone-cluster
```

---

## 📋 Checklist produzione

* HA abilitato
* backup configurato
* monitoring attivo
* sicurezza attiva
* logging centralizzato

---

## 🔥 Comandi utili

```bash
kubectl get all -n ozone-cluster
kubectl top pods -n ozone-cluster
kubectl logs -f <pod>
```

---

## 🚀 Conclusione

Questa guida permette di operare il sistema in modo efficace, mantenendo:

* affidabilità
* scalabilità
* performance

---
