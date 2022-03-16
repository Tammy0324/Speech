from fastapi import FastAPI, File, UploadFile

app = FastAPI()

@app.post("/files/")
async def create_upload_file(file: UploadFile):
    return {"file_name": file.filename,
            "file": file}

@app.get("/")
def hello():
    return{"Hello": "World"}