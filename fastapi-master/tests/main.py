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
list = []


def ran():
    a = random.choice('0')
    while True:
        b = random.choice('0123456789')
        c = random.choice('0123456789')
        if int(b) * 10 + int(c) < 76:
            break
    sum = a + b + c
    dic = {'article_num': sum}
    article.update(dic)


def get_article(n: int):
    if n == 0:
        dic = {'article_num': 0, 'len': 0, 'sen': 0}
        article.update(dic)

    else:
        url = "https://www.eslfast.com/kidsenglish/ke/ke{}.htm"
        r = requests.get(url.format(article['article_num']))
        soup = BeautifulSoup(r.text, "html.parser")
        sel = soup.select('div.content-body div.contain font')

        # 處理文章內容
        contain = ""
        text = ""
        for s in sel:
            contain = s.text
        arr = contain.split('\n')
        for i in range(1, len(arr)):
            text += arr[i]
            text += " "
        print(article['article_num'])
        print("")
        sen = nltk.sent_tokenize(text)
        l = len(sen)
        print("l = ", l)
        sentence = "\n"
        for i in sen:
            temp = ""
            sentence += i
            temp += i
            list.append(temp)
            sentence += "\n"
        dic = {'len': l, 'sen': sentence}
        article.update(dic)


filePath = "voice/{}/{}.mp3"
article = {}
get_article(0)


@app.get('/article')
def create_item():
    ran()
    get_article(1)
    print(article)
    return article['sen']


@app.post("/recorder/{num}")
async def root(file: UploadFile = File(...)):
    print("file_name", file.filename)
    # 下載被上傳的音檔
    with open(file.filename, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)



@app.get("/example/{example_num}")
async def example(example_num):
    print('article: ', article['article_num'], 'example: ', example_num)
    print(filePath.format(article['article_num'], example_num))
    return FileResponse(filePath.format(article['article_num'], example_num))


@app.get('/result/{num}')
async def _result(num):
    file = "Audio{}.wav"
    speech_config = speechsdk.SpeechConfig(subscription="b751009eb5f545f8a4d0ce3cab8d7c71", region="eastasia")
    audio_config = speechsdk.audio.AudioConfig(filename=file.format(num))
    speech_recognizer = speechsdk.SpeechRecognizer(speech_config=speech_config, audio_config=audio_config)
    sen = speech_recognizer.recognize_once_async().get()
    result = sen.text
    print("result = ", result)
    ratio = match(result, num)
    return num, ratio


# sen為錄音檔中的文字內容，num為錄音檔對應到的句子編號
def match(sen, num):
    print(list)
    index = int(num) - 1
    ans = list[index]
    ratio = SequenceMatcher(None, sen, ans).ratio()
    print("ans = ", ans)
    print("sen = ", sen)
    return ratio

# def test(n: int):
#     if n == 0:
#         dic = {'article_num': 0, 'len': 0, 'sen': 0}
#         article.update(dic)
#     else:
#         url = "https://www.eslfast.com/kidsenglish/ke/ke{}.htm"
#         r = requests.get(url.format(article['article_num']))
#         soup = BeautifulSoup(r.text, "html.parser")
#         sel = soup.select('div.content-body div.contain font')
#
#         # 處理文章內容
#         contain = ""
#         text = ""
#         for s in sel:
#             contain = s.text
#         arr = contain.split('\n')
#         for i in range(1, len(arr)):
#             text += arr[i]
#             text += " "
#         print(article['article_num'])
#         print("")
#         sen = nltk.sent_tokenize(article)
#         l = len(sen)
#         print("l = ", l)
#         sentence = "\n"
#         list = []
#         for i in sen:
#             temp = ""
#             sentence += i
#             temp += i
#             list.append(temp)
#             sentence += "\n"
#         dic = {'article_num': 1, 'len': l, 'sen': sentence}
#         article.update(dic)
#
#
# article = {}
# test(0)
# print(article)
