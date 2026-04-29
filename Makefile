# =========================
# Load env
# =========================
include .env
export

# =========================
# Default
# =========================
.PHONY: help

help:
	@echo "📦 Comandi disponibili:"
	@echo " make deploy        → Deploy cluster"
	@echo " make destroy       → Teardown cluster"
	@echo " make build         → Build API Docker image"
	@echo " make push          → Push image (se configurato)"
	@echo " make init          → Init Ozone (bucket)"
	@echo " make port-forward  → Accesso locale"
	@echo " make logs          → Logs API"
	@echo " make status        → Stato pod"
	@echo " make test          → Test API upload"

# =========================
# Deploy
# =========================
deploy:
	@echo "🚀 Deploy cluster..."
	./scripts/1.deploy.sh

destroy:
	@echo "💣 Destroy cluster..."
	./scripts/2.teardown.sh

# =========================
# Docker
# =========================
build:
	@echo "🐳 Build API image..."
	docker build -t $(DOCKER_IMAGE):$(DOCKER_TAG) ./api

push:
	@echo "📤 Push image..."
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)

# =========================
# Ozone init
# =========================
init:
	@echo "🔧 Init Ozone..."
	./scripts/3.init-ozone.sh

# =========================
# Access
# =========================
port-forward:
	@echo "🔌 Port forward..."
	./scripts/4.port-forward.sh

# =========================
# Debug
# =========================
logs:
	kubectl logs -l app=ozone-api -n $(NAMESPACE) --tail=100 -f

status:
	kubectl get pods -n $(NAMESPACE)

describe:
	kubectl describe pods -n $(NAMESPACE)

# =========================
# Test
# =========================
test:
	@echo "🧪 Test upload..."
	curl -X POST -F "file=@README.md" http://$(API_HOST):$(API_PORT)/upload

# =========================
# Clean local
# =========================
clean:
	@echo "🧹 Cleanup locale..."
	rm -rf __pycache__
	find . -name "*.pyc" -delete