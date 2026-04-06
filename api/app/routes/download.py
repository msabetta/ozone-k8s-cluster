from fastapi import APIRouter, HTTPException
from fastapi.responses import StreamingResponse
from app.services.ozone_client import download_file

router = APIRouter()

@router.get("/download/{filename}")
def download(filename: str):
    try:
        data = download_file(filename)

        return StreamingResponse(
            iter([data]),
            media_type="application/octet-stream",
            headers={"Content-Disposition": f"attachment; filename={filename}"}
        )

    except Exception as e:
        raise HTTPException(status_code=404, detail=str(e))