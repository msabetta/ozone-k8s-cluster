# 🚀 Ozone Kubernetes Cluster + High-Speed Data Ingestion API

Questo progetto implementa un cluster completo di **Apache Ozone** su **Kubernetes**, con:

* Storage distribuito (OM + SCM + DataNode)
* Gateway S3 compatibile
* API REST per upload/download
* Integrazione pronta per ingestion ad alta velocità (Kafka)

---

# 🧩 Architettura

```
Clients / API / IoT
        ↓
     FastAPI
        ↓
   Ozone S3 Gateway
        ↓
   Ozone Manager (OM)
        ↓
   SCM (metadata + containers)
        ↓
   DataNodes (storage distribuito)
```

---

# 📁 Struttura del progetto

```
ozone-k8s-cluster/
│
├── api/                # API FastAPI
├── k8s/                # manifest Kubernetes
├── scripts/            # script di gestione
├── connectors/         # config Kafka Connect
├── monitoring/         # Prometheus / Grafana (opzionale)
├── kafka/              # pipeline ingestion (opzionale)
├── docs/               # documentazione
├── .env                # configurazione
├── Makefile            # comandi automatizzati
└── README.md
```

---

# ⚙️ Prerequisiti

Assicurati di avere installato:

* **kubectl**
* **Docker**
* **AWS CLI**
* Cluster Kubernetes (es. Minikube, Kind, EKS)

---

# 🔧 Configurazione

Modifica il file `.env`:

```bash
S3_ENDPOINT=http://localhost:9878
S3_BUCKET=iot-data
API_PORT=8000
```

---

# 🚀 Quick Start

## 1. Build API

```bash
eval $(minikube docker-env)
make build
```

---

## 2. Deploy cluster

```bash
minikube start --memory=4096 --cpus=2
make deploy
```

---

## 3. Port-forward

```bash
make port-forward
```

---

## 4. Inizializza Ozone

```bash
make init
```

---

## 5. Test API

```bash
make test
```

---

# 📡 API disponibili

Base URL:

```
http://localhost:8000
```

---

## 📤 Upload file

```bash
curl -X POST -F "file=@test.txt" http://localhost:8000/upload
```

---

## 📥 Download file

```bash
curl http://localhost:8000/download/test.txt
```

---

## ❤️ Health check

```bash
curl http://localhost:8000/health
```

---

# 📦 Accesso diretto S3

```bash
aws --endpoint-url=http://localhost:9878 s3 ls
```

---

# ⚡ Data ingestion ad alta velocità

Il sistema è pronto per integrarsi con:

* Apache Kafka
* Kafka Connect

### Flusso:

```
Producer → Kafka → Kafka Connect → Ozone
```

---

# 🛠️ Comandi Makefile

```bash
make help
```

Principali:

* `make deploy` → deploy cluster
* `make destroy` → elimina cluster
* `make build` → build API
* `make init` → crea bucket
* `make port-forward` → accesso locale
* `make logs` → log API
* `make status` → stato pod

---

# 📊 Monitoraggio (opzionale)

Puoi integrare:

* Prometheus
* Grafana

Cartella:

```
monitoring/
```

---

# ⚠️ Limitazioni (setup base)

Questa configurazione è **dev/test oriented**:

* singolo OM e SCM
* replica limitata
* sicurezza disabilitata

---

# 🔒 Hardening per produzione

Per ambiente enterprise:

* TLS + autenticazione
* HA (3x OM, 3x SCM)
* DataNode ≥ 5
* Persistent Volume ottimizzati (SSD/HDD)
* Backup & snapshot

---

# 📈 Scalabilità

Puoi scalare facilmente:

```bash
kubectl scale statefulset datanode --replicas=5 -n ozone-cluster
```

---

# 🧠 Best practice

* usare Parquet per ingestion
* evitare piccoli file
* partizionare per tempo
* usare batch ingestion

---

# 🧪 Troubleshooting

## Pod non pronti

```bash
kubectl get pods -n ozone-cluster
kubectl describe pod <pod>
```

---

## Log API

```bash
make logs
```

---

## Reset completo

```bash
make destroy
```

---

# 🔥 Roadmap evolutiva

Possibili miglioramenti:

* Helm chart
* CI/CD pipeline
* Multi-tenant storage
* Streaming con Flink
* Query engine (Trino)

---

# 🤝 Contributi

Pull request e miglioramenti sono benvenuti!

---

# 📄 Licenza

MIT
