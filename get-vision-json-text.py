import json
import sys
import os
import re

folder_name = sys.argv[1]

def list_json_files(folder_name):
    return [os.path.join(folder_name,f) for f in os.listdir(folder_name) if os.path.isfile(os.path.join(folder_name,f)) and f[-5:] == '.json' ]

def get_page_number(file_name):
    # we expect the name to be of format PREFIX-N-to-N.json. need to extract page number N
    # 
    pattern = '-([0-9]+)-'
    pageno  =  re.search(pattern,file_name).group(1)
    return int(pageno)

def extract_text_from_json(json_file):
    with open(json_file,'r') as f:
        data = json.load(f)
        try:
            text = data['responses'][0]['fullTextAnnotation']['text']
        except:
            text = ''
    return text

for f in sorted(list_json_files(folder_name), key=get_page_number):
    print(get_page_number(f))
    print(extract_text_from_json(f))


