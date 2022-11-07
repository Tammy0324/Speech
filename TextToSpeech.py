#from ast import Num
#from re import X
import azure.cognitiveservices.speech as speechsdk
import requests
from bs4 import BeautifulSoup
import random
import os

print("New cwd = " + os.getcwd())

speech_config = speechsdk.SpeechConfig(subscription="b751009eb5f545f8a4d0ce3cab8d7c71", region="eastasia")

speech_config.speech_synthesis_language = "en-US"

#from urllib.parse import urlparse
#import requests
#from bs4 import BeautifulSoup 

url = "https://www.eslfast.com/kidsenglish/ke/ke{}{}{}.htm"

a = random.choice('0')
b = random.choice('1234567890')
c = random.choice('1234567890')

#for t in  :
  #print(url.format(t))
r=requests.get(url.format(a,b,c))
soup=BeautifulSoup(r.text, "html.parser")
sel=soup.select('div.content-body font p')
#type(sel)
#print('sel: ', sel)
string = ""
for s in sel:
  string = s.text
  #print(s.text)
print(string)

audio_config = speechsdk.audio.AudioOutputConfig(filename="voice\example.mp3")
synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config, audio_config=audio_config)
synthesizer.speak_text_async(string)

# r=requests.get("https://www.eslfast.com/kidsenglish/ke/ke001.htm")
# soup=BeautifulSoup(r.text, "html.parser")
# sel=soup.select('div p.read_text font')

# string = ""

# for s in sel:
#   string = s.text
  
# print(string)

# audio_config = speechsdk.audio.AudioOutputConfig(use_default_speaker=True)

# synthesizer = speechsdk.SpeechSynthesizer(speech_config=speech_config, audio_config=audio_config)
# synthesizer.speak_text_async(string)