# ⚙️ Ansible Playbooks - Guida all'utilizzo

Questa guida descrive come utilizzare i playbook basati su **Ansible** per automatizzare il deploy e la gestione della piattaforma:

* Apache Ozone
* Apache Kafka
* Kubernetes
* API basate su FastAPI

---

# 📁 Struttura

```id="c2xl02"
ansible/
├── inventory/
├── group_vars/
├── roles/
├── playbooks/
└── ansible.cfg
```

---

# ⚙️ Prerequisiti

Assicurati di avere installato:

* Ansible ≥ 2.10
* kubectl configurato
* Docker
* AWS CLI

Verifica:

```bash id="0h5ghg"
ansible --version
kubectl version --client
```

---

# 🌍 Configurazione

## Inventory

```yaml id="4x8pwz"
all:
  hosts:
    localhost:
      ansible_connection: local
```

---

## Variabili globali

File: `group_vars/all.yml`

```yaml id="qp1ljm"
namespace: ozone-cluster
s3_bucket: iot-data
```

---

# 🚀 Playbook disponibili

## 🔹 Deploy completo

```bash id="f11u5d"
ansible-playbook ansible/playbooks/deploy.yml
```

Deploya:

* Ozone (OM, SCM, DataNode)
* Kafka
* API

---

## 🔹 Inizializzazione Ozone

```bash id="29k1y2"
ansible-playbook ansible/playbooks/init-ozone.yml
```

Crea:

* bucket S3
* struttura base storage

---

## 🔹 Port-forward

```bash id="t8k1mn"
ansible-playbook ansible/playbooks/port-forward.yml
```

Espone:

* API → [http://localhost:8000](http://localhost:8000)
* S3 → [http://localhost:9878](http://localhost:9878)

---

## 🔹 Teardown (cleanup completo)

```bash id="g4r3cf"
ansible-playbook ansible/playbooks/teardown.yml
```

Rimuove:

* tutte le risorse Kubernetes
* namespace

---

# 🧩 Ruoli (Roles)

| Role   | Descrizione          |
| ------ | -------------------- |
| common | Check prerequisiti   |
| k8s    | Deploy cluster Ozone |
| kafka  | Deploy Kafka         |
| api    | Deploy API           |
| ozone  | Init bucket          |

---

# 🔄 Workflow consigliato

```bash id="dz1zd4"
# 1. Deploy
ansible-playbook ansible/playbooks/deploy.yml

# 2. Esporre servizi
ansible-playbook ansible/playbooks/port-forward.yml

# 3. Init storage
ansible-playbook ansible/playbooks/init-ozone.yml
```

---

# 🧪 Test

Dopo il deploy:

```bash id="fcz2s2"
curl http://localhost:8000/api/health
```

---

# ⚠️ Troubleshooting

## ❌ kubectl non funziona

```bash id="2k3b7o"
kubectl get pods
```

Verifica contesto Kubernetes.

---

## ❌ API non disponibile

```bash id="8b9y2o"
kubectl logs -l app=ozone-api -n ozone-cluster
```

---

## ❌ S3 non raggiungibile

```bash id="1m2o3n"
kubectl port-forward svc/s3g 9878:9878 -n ozone-cluster
```

---

## ❌ Bucket non creato

```bash id="p3m9r2"
ansible-playbook ansible/playbooks/init-ozone.yml
```

---

# 📊 Best practice

* usare variabili (`group_vars`) invece di hardcoding
* separare ambienti (`dev`, `prod`)
* usare tag Ansible per deploy parziali

Esempio:

```bash id="6g8h2k"
ansible-playbook deploy.yml --tags kafka
```

---

# 🔐 Sicurezza

Consigli:

* non usare credenziali default
* usare vault Ansible (`ansible-vault`)
* limitare accesso cluster

---

# 📈 Scalabilità

Puoi estendere facilmente:

* più DataNode
* cluster Kafka multi-broker
* replica API

---

# 🔥 Estensioni possibili

* deploy con Helm
* GitOps (ArgoCD)
* CI/CD pipeline
* multi-cluster

---

# 📚 Risorse utili

* Documentazione ufficiale Ansible
* Documentazione Kubernetes
* Documentazione Apache Ozone

---

# 🚀 Conclusione

I playbook Ansible permettono di:

* automatizzare completamente il deploy
* garantire consistenza tra ambienti
* semplificare operazioni DevOps
