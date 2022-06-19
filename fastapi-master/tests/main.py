import uvicorn
import azure.cognitiveservices.speech as speechsdk
from fastapi import FastAPI, File, UploadFile
from typing import Optional
from pydantic import BaseModel
import requests
from bs4 import BeautifulSoup
import random
import os, sys
import shutil
from fastapi.responses import FileResponse

app = FastAPI()

url = "https://www.eslfast.com/kidsenglish/ke/ke{}{}{}.htm"

a = random.choice('0')
b = random.choice('1234567890')
c = random.choice('1234567890')

r = requests.get(url.format(a, b, c))
soup = BeautifulSoup(r.text, "html.parser")
sel = soup.select('div.content-body font p')
string = ""
for s in sel:
    string = s.text

arr = string.split('\n')
string = arr[2]
# print(string)
# print(len(string))
arr = string.split('.')  # len(arr) = 文章句數
for j in range(0, len(arr) - 1):
    string = arr[j]
    # print(string)
    # print(len(string))
    if len(string) < 3:  # 解決Mr. Ms.之類的句點斷句問題
        string += '.'
        string += arr[j + 1]

    print(string)
    # string = '[{"body": "'+string+'"}]'
    # print(string)
file_path = "C:/Users/user/Documents/GitHub/Speech/voice/001/1.mp3"

@app.get('/')
def create_item():
    return string

@app.get("/download-file")
def download_file():
    return FileResponse(path=file_path, filename=file_path)


@app.post("/")
async def root(file: UploadFile = File(...)):
    print("file_name", file.filename)
#     destination_file_path = "C:/Users/user/Documents/GitHub/Speech/voice/"+file.filename

    with open(file.filename,"wb") as buffer:
         shutil.copyfileobj(file.file,buffer)



