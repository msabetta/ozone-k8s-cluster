from fastapi import APIRouter, UploadFile, File, HTTPException
from app.services.ozone_client import upload_file

router = APIRouter()

@router.post("/upload")
async def upload(file: UploadFile = File(...)):
    try:
        content = await file.read()
        upload_file(file.filename, content)

        return {
            "status": "uploaded",
            "filename": file.filename,
            "size": len(content)
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))