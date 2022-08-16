from fastapi import FastAPI, File, UploadFile
import requests
from bs4 import BeautifulSoup
import random
import shutil
from fastapi.responses import FileResponse
import json

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
article = string
# print(string)
# print(len(string))
arr = string.split('.')  # len(arr) = 文章句數
l = len(arr)  # 文章句數
print(a, b, c)
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

'''
file_path = 'voice/{}{}{}/{}.mp3'
file_list = []          ## 空列表
for i in range(1,l,1):
    filepath = file_path.format(a,b,c,i)
    file_list.append(filepath)   ## 使用 append() 添加元素
    print(i)
print(file_list)

with zipfile.ZipFile('temp.zip', 'w') as zipF:
    for file in file_list:
        zipF.write(file, compress_type=zipfile.ZIP_DEFLATED)

FilePath = 'temp.zip'
'''

filePath = "voice/{}{}{}/{}.mp3"

with open('jsonfile.json','r') as f:
    json_object = json.loads(f.read())

accuracy = str(json_object['NBest'][0]['AccuracyScore'])
fluency = str(json_object['NBest'][0]['FluencyScore'])
complete = str(json_object['NBest'][0]['CompletenessScore'])
pron = str(json_object['NBest'][0]['PronScore'])


@app.get('/')
def create_item():
    return article


@app.post("/")
async def root(file: UploadFile = File(...)):
    print("file_name", file.filename)
    #     destination_file_path = "C:/Users/user/Documents/GitHub/Speech/voice/"+file.filename

    with open(file.filename, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)


@app.get("/download_file")
def download_file():
    return FileResponse(path=filePath.format(a, b, c, l - 1), filename=filePath.format(a, b, c, l - 1))


for i in range(1, l):
    @app.get("/example/{example_num}")
    async def example(example_num):
        print(example_num)
        print(a, b, c)
        print(filePath.format(a, b, c, example_num))
        return FileResponse(filePath.format(a, b, c, example_num))

@app.get('/result')
def result():
    # return accuracy,fluency,complete,pron
    return accuracy