import json

with open('jsonfile.json','r') as f:
    json_object = json.loads(f.read())

accuracy = json_object['NBest'][0]['AccuracyScore']
fluency = json_object['NBest'][0]['FluencyScore']
complete = json_object['NBest'][0]['CompletenessScore']
pron = json_object['NBest'][0]['PronScore']
# print(accuracy)
# print(fluency)
# print(complete)
# print(pron)