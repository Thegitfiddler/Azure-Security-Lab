from fastapi import FastAPI
from datetime import datetime

app = FastAPI(
    title="Azure Security Lab API",
    description="Sample app for the Azure Security Lab DevSecOps pipeline",
    version="1.0.0"
)

@app.get("/")
def root():
    return {
        "message": "Azure Security Lab API",
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat()
    }

@app.get("/health")
def health():
    return {
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat()
    }

@app.get("/info")
def info():
    return {
        "project": "Azure Security Lab",
        "owner": "Mike",
        "phases": [
            "Phase 1: Identity & Zero Trust",
            "Phase 2: Microsoft Sentinel",
            "Phase 3: Defender for Cloud",
            "Phase 4: Secure DevOps Pipeline"
        ]
    }