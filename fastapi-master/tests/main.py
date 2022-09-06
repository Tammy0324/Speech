from fastapi import FastAPI, UploadFile, File
import requests
from bs4 import BeautifulSoup
import random
import shutil
from fastapi.responses import FileResponse
import nltk
import azure.cognitiveservices.speech as speechsdk
from difflib import *

app = FastAPI()

url = "https://www.eslfast.com/kidsenglish/ke/ke{}{}{}.htm"

a = random.choice('0')
while True:
    b = random.choice('5')
    c = random.choice('7')
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
print("")
sen = nltk.sent_tokenize(article)
l = len(sen)
print("l = ", l)
sentence = "\n"
list = []
for i in sen:
    sentence = ""
    sentence += i
    list.append(sentence)
    sentence += "\n"
print(list)

filePath = "voice/{}{}{}/{}.mp3"


@app.get('/article')
def create_item():
    return sentence


@app.post("/recorder/{num}")
async def root(file: UploadFile = File(...)):
    print("file_name", file.filename)
    # 下載被上傳的音檔
    with open(file.filename, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)


for i in range(1, l + 1):
    @app.get("/example/{example_num}")
    async def example(example_num):
        print(example_num)
        print(a, b, c)
        print(filePath.format(a, b, c, example_num))
        return FileResponse(filePath.format(a, b, c, example_num))


@app.get('/result/{num}')
async def _result(num: int):
    # return accuracy,fluency,complete,pron
    file = "Audio{}.wav"
    speech_config = speechsdk.SpeechConfig(subscription="b751009eb5f545f8a4d0ce3cab8d7c71", region="eastasia")
    audio_config = speechsdk.audio.AudioConfig(filename=file.format(num))
    speech_recognizer = speechsdk.SpeechRecognizer(speech_config=speech_config, audio_config=audio_config)
    sen = speech_recognizer.recognize_once_async().get()
    result = sen.text
    print("result = ", result)
    ratio = match(result, num)
    return result, ratio


# sen為錄音檔中的文字內容，num為錄音檔對應到的句子編號
def match(sen, num):
    ans = list[num-1]
    ratio = SequenceMatcher(None, sen, ans).ratio()
    print("ans = ", ans)
    print("sen = ", sen)
    return ratio
