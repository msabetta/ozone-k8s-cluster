# 📡 Ozone API - Guida Utente

Questa guida descrive come utilizzare le API REST per interagire con lo storage basato su **Apache Ozone**.

Le API sono sviluppate con **FastAPI** e permettono di:

* caricare file (upload)
* scaricare file (download)
* verificare lo stato del servizio

---

# 🌐 Base URL

In ambiente locale:

```bash
http://localhost:8000/api
```

---

# 🔐 Autenticazione

👉 Versione attuale:

* Nessuna autenticazione richiesta

👉 In produzione (consigliato):

* JWT / OAuth2
* API Key

---

# 📤 Upload file

## Endpoint

```bash
POST /upload
```

---

## Esempio richiesta

```bash
curl -X POST \
  -F "file=@test.txt" \
  http://localhost:8000/api/upload
```

---

## Risposta

```json
{
  "status": "uploaded",
  "filename": "test.txt",
  "size": 1234
}
```

---

## Note

* Il file viene salvato nello storage Ozone tramite gateway S3
* Il nome file è usato come chiave (key)

---

# 📥 Download file

## Endpoint

```bash
GET /download/{filename}
```

---

## Esempio richiesta

```bash
curl -O http://localhost:8000/api/download/test.txt
```

---

## Comportamento

* Restituisce il file come stream binario
* Header `Content-Disposition` impostato per download diretto

---

## Errori

| Codice | Descrizione      |
| ------ | ---------------- |
| 404    | File non trovato |
| 500    | Errore interno   |

---

# ❤️ Health Check

## Endpoint

```bash
GET /health
```

---

## Esempio

```bash
curl http://localhost:8000/api/health
```

---

## Risposta

```json
{
  "status": "ok"
}
```

---

# 📦 Integrazione con S3 (Ozone)

Le API utilizzano il gateway S3 di Ozone:

```bash
http://localhost:9878
```

Puoi verificare direttamente:

```bash
aws --endpoint-url=http://localhost:9878 s3 ls
```

---

# ⚡ Best Practice

### 📁 Naming file

* evitare spazi
* usare timestamp o UUID

Esempio:

```text
device1_2026-04-06T14-00.json
```

---

### 📦 File grandi

* usare upload chunked (non ancora implementato)
* evitare upload > 100MB in singola richiesta

---

### 🧠 Performance

* batch upload se possibile
* compressione lato client

---

# 🧪 Troubleshooting

## API non raggiungibile

```bash
kubectl get pods -n ozone-cluster
```

---

## Log API

```bash
kubectl logs -l app=ozone-api -n ozone-cluster
```

---

## Errore upload

Verifica:

* bucket esistente
* S3 gateway attivo
* credenziali corrette

---

# 📊 Codici di stato HTTP

| Codice | Significato      |
| ------ | ---------------- |
| 200    | OK               |
| 201    | Creato           |
| 400    | Richiesta errata |
| 404    | Non trovato      |
| 500    | Errore server    |

---

# 🔄 Workflow tipico

```text
1. Upload file → API
2. File salvato su Ozone
3. Download o analisi dati
```

---

# 🔥 Evoluzioni future

Le API possono essere estese con:

* autenticazione
* metadata file
* versioning
* integrazione con Apache Kafka
* pipeline real-time

---

# 📚 Swagger UI

FastAPI fornisce documentazione interattiva:

```bash
http://localhost:8000/docs
```

---

# 👨‍💻 Supporto

Per problemi:

* controlla i log
* verifica lo stato del cluster
* assicurati che Ozone sia attivo

---

# 🚀 Conclusione

Queste API forniscono un'interfaccia semplice e potente per lavorare con uno storage distribuito scalabile basato su Ozone.

Perfette per:

* ingestion dati
* archiviazione file
* pipeline data engineering

---
