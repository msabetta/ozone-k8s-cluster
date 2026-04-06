# 🧩 Architecture Overview

## 📌 Introduzione

Questo progetto implementa una piattaforma di data ingestion e storage distribuito basata su:

* Apache Ozone
* Apache Kafka
* Kubernetes
* FastAPI

L’obiettivo è fornire una soluzione scalabile per:

* ingestion ad alta velocità
* storage persistente
* accesso tramite API

---

## 🧱 Componenti principali

### 1. Ozone Cluster

#### 🔹 Ozone Manager (OM)

* Gestisce metadata
* Namespace (volumi, bucket)

#### 🔹 Storage Container Manager (SCM)

* Gestione container
* Replica e allocazione

#### 🔹 DataNode

* Storage fisico dei dati
* Scalabile orizzontalmente

#### 🔹 S3 Gateway

* Espone API compatibili S3
* Interfaccia principale per accesso dati

---

### 2. Streaming Layer

#### Apache Kafka

* Buffer dati ad alta velocità
* Decoupling tra producer e storage

#### Kafka Connect

* Sink verso Ozone (S3)
* Gestione batch e retry

---

### 3. API Layer

#### FastAPI

* Upload/download file
* Health check
* Gateway applicativo

---

### 4. Orchestrazione

#### Kubernetes

* Deploy container
* Scaling
* Self-healing

---

## 🔄 Flussi dati

### 📤 Upload diretto via API

```text
Client → API → S3 Gateway → Ozone → DataNode
```

---

### ⚡ Ingestion streaming

```text
Producer → Kafka → Kafka Connect → Ozone S3 → DataNode
```

---

## 📦 Storage layout

Struttura consigliata:

```text
bucket/
└── year=YYYY/
    └── month=MM/
        └── day=DD/
            └── hour=HH/
                └── file.parquet
```

---

## 📊 Formati dati

| Formato | Uso              |
| ------- | ---------------- |
| JSON    | ingestione       |
| Parquet | analytics        |
| Avro    | schema evolution |

---

## 📈 Scalabilità

### Orizzontale

* DataNode → aggiunta nodi
* Kafka → più broker
* API → replica deployment

---

### Verticale

* CPU / RAM pod
* storage per PVC

---

## 🔐 Sicurezza (target)

* TLS (API + S3)
* autenticazione (JWT / Kerberos)
* isolamento namespace

---

## 🧠 Decisioni architetturali

### Perché Ozone?

* ottimizzato per big data
* migliore gestione file piccoli rispetto a HDFS
* compatibilità S3

---

### Perché Kafka?

* resilienza
* buffering
* scalabilità ingestion

---

### Perché FastAPI?

* performance elevate
* async I/O
* integrazione semplice

---

## 🔥 Evoluzione futura

* HA cluster Ozone (multi OM/SCM)
* Kafka KRaft mode (no Zookeeper)
* query engine (Trino)
* data lakehouse architecture

---
