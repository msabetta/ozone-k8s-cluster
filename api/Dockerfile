FROM python:3.11-slim

# Evita buffer output (utile nei log K8s)
ENV PYTHONUNBUFFERED=1

# Working directory
WORKDIR /app

# Installa dipendenze
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia tutto il codice
COPY . /app

# Espone porta
EXPOSE 8000

# Avvio corretto
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]