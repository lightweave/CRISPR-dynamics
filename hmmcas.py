# before use run in command shell:
# pip install pipenv
# pipenv install requests

import requests
import re


r = requests.get('http://immunet.cn/hmmcas') # this is optional

url = "http://immunet.cn/hmmcas/upload2.php"
payload = {'sequence': '>gi|347755963|ref|YP_004863525.1| hypothetical protein [Candidatus Chloracidobacterium thermophilum B] MSDTTPLPFPPHYDPIQTVAAEYPGTAPQALFAPAMAWQQAHSLRPAADDARRAHLLVIDMQVDFCFPSGTLYVAGRSGTGGTDALRRTVEFMYRYLPWISEITCTLDSHVPGQVFFPGAHLTEDGAPVAPHTVITAADYRAGRYRPNPALAAQLGVTTEWLTHQVTDYCTRLEATGKYALYVWPYHCLVGTAGHRLAGVLADACLFHAFARGAANAPVLKGDSPLTENYSVFAPEVTTCWDGQPMPGAVRHEALLKRLLTADVILVAGLASSHCVAASVADLLAFVQEHNPYLAHRIVLLRDAMAPVVVPGADFTDAAEQALASFEAAGARVLTTDDPVEAWWG', 
			'key2': 'value2'}

print("request to "+ url)		
r = requests.post(url, data=payload)


#print(r.text)


# button for:
#url2 = "http://i.uestc.edu.cn/hmmcas/operon.php?qsf=ToSlide175938&tb=Table175938&sp=3"
#url2 = "http://i.uestc.edu.cn/hmmcas/operon.php?qsf=ToSlide031405&tb=Table031405&sp=3"
# Search links on buttons:
matches = re.findall("(http\:\/\/i\.uestc\.edu\.cn\/hmmcas\/operon\.php\?qsf=ToSlide.\d+\&tb=Table\d+\&sp=3)", r.text)

print("found " + matches[1])

url2 = matches[1]

r = requests.get(url2)



################# alernate
#url = 'http://immunet.cn/hmmcas'
#files = {'file': open('testgenom.txt', 'rb')}
#r = requests.post(url, files=files) 