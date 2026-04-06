from fastapi import FastAPI
from app.routes import upload, download, health

app = FastAPI()

app.include_router(upload.router)
app.include_router(download.router)
app.include_router(health.router)