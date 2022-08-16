from fastapi import FastAPI, UploadFile, File
import requests
from bs4 import BeautifulSoup
import random
import shutil
from fastapi.responses import FileResponse
import nltk

app = FastAPI()

url = "https://www.eslfast.com/kidsenglish/ke/ke{}{}{}.htm"

a = random.choice('0')
while True:
    b = random.choice('1234567')
    c = random.choice('1234567890')
    if int(b) * 10 + int(c) < 76:
        break

r = requests.get(url.format(a, b, c))
soup = BeautifulSoup(r.text, "html.parser")
sel = soup.select('div.content-body div.contain font')


# 處理文章內容
contain = ""
article = ""
for s in sel:
    contain = s.text
arr = contain.split('\n')
for i in range(1, len(arr)):
    article += arr[i]
    article += " "
print(a, b, c)
print(article)
print("")
sen = nltk.sent_tokenize(article)
print(sen)
l = len(sen)
print("l = ", l)
sentence = "\n"
for i in sen:
    sentence += i
    sentence += "\n"
print(sentence)

filePath = "voice/{}{}{}/{}.mp3"


@app.get('/article')
def create_item():
    return sentence


@app.post("/")
async def root(file: UploadFile = File(...)):
    print("file_name", file.filename)
    #     destination_file_path = "C:/Users/user/Documents/GitHub/Speech/voice/"+file.filename

    with open(file.filename, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)


@app.get("/download_file")
def download_file():
    return FileResponse(path=filePath.format(a, b, c, l - 1), filename=filePath.format(a, b, c, l - 1))


for i in range(1, l+1):
    @app.get("/example/{example_num}")
    async def example(example_num):
        print(example_num)
        print(a, b, c)
        print(filePath.format(a, b, c, example_num))
        return FileResponse(filePath.format(a, b, c, example_num))
