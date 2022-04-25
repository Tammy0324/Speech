import azure.cognitiveservices.speech as speechsdk
from fastapi import FastAPI
from typing import Optional
from pydantic import BaseModel
import requests
from bs4 import BeautifulSoup
import random
import os

app = FastAPI()


url = "https://www.eslfast.com/kidsenglish/ke/ke034.htm"

#a = random.choice('0')
#b = random.choice('1234567890')
#c = random.choice('1234567890')

r=requests.get(url)
soup=BeautifulSoup(r.text, "html.parser")
sel=soup.select('div.content-body font p')
string = ""
for s in sel:
    string = s.text
    
arr = string.split('\n')
string = arr[2]
#print(string)
#print(len(string))
arr = string.split('.') #len(arr) = 文章句數
for j in range(0,len(arr)-1):
    string = arr[j]
    #print(string)
    #print(len(string))
    if len(string) < 3: #解決Mr. Ms.之類的句點斷句問題
        string += '.'
        string += arr[j+1]
        
    print(string)
    #string = '[{"body": "'+string+'"}]'
    #print(string)

@app.get('/')
def create_item():
    return string