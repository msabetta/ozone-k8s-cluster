from pydantic import BaseModel

class FileResponse(BaseModel):
    filename: str
    md5: str
    size: int
    status: str
    path: str
    created_at: str
    updated_at: str