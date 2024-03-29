import azure.cognitiveservices.speech as speechsdk

speech_config = speechsdk.SpeechConfig(subscription="b751009eb5f545f8a4d0ce3cab8d7c71", region="eastasia")

audio_config = speechsdk.audio.AudioConfig(filename="Audio1.wav")
speech_recognizer = speechsdk.SpeechRecognizer(speech_config=speech_config, audio_config=audio_config)
result = speech_recognizer.recognize_once_async().get()
print(result.text)

# done = False
#
#
# def stop_cb(evt):
#     speech_recognizer.stop_continuous_recognition()
#     global done
#     done = True

# def cutString(evt):
#     evt = str(evt)
#     arr = evt.split(', ')
#     text = arr[2]
#     arr2 = text.split('"')
#     # print(arr2[1])
#     s = arr2[1]
#     if s in main.string:
#         # result = "great"
#         print("perfact")
#     else:
#         # result = s
#         print("sentence:")
#         print(main.string)
#         print("you said:")
#         print(s)


# speech_recognizer.recognized.connect(lambda evt: cutString(evt))

# speech_recognizer.session_stopped.connect(stop_cb)
# speech_recognizer.canceled.connect(stop_cb)
#
# speech_recognizer.start_continuous_recognition()
# while not done:
#     time.sleep(.5)
