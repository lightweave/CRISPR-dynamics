# before use run in command shell:
# pip install pipenv
# pipenv install requests

import requests
import re
from lxml import etree

r = requests.get('http://immunet.cn/hmmcas') # this is optional

url = "http://immunet.cn/hmmcas/upload2.php"
payload = {'sequence': '>gi|347755963|ref|YP_004863525.1| hypothetical protein [Candidatus Chloracidobacterium thermophilum B] MSDTTPLPFPPHYDPIQTVAAEYPGTAPQALFAPAMAWQQAHSLRPAADDARRAHLLVIDMQVDFCFPSGTLYVAGRSGTGGTDALRRTVEFMYRYLPWISEITCTLDSHVPGQVFFPGAHLTEDGAPVAPHTVITAADYRAGRYRPNPALAAQLGVTTEWLTHQVTDYCTRLEATGKYALYVWPYHCLVGTAGHRLAGVLADACLFHAFARGAANAPVLKGDSPLTENYSVFAPEVTTCWDGQPMPGAVRHEALLKRLLTADVILVAGLASSHCVAASVADLLAFVQEHNPYLAHRIVLLRDAMAPVVVPGADFTDAAEQALASFEAAGARVLTTDDPVEAWWG', 
			'key2': 'value2'}

print("request to "+ url)		
#r = requests.post(url, data=payload)

################# alernate
files = {'uploadfile': open('NC_016025.faa', 'rb')}
r = requests.post(url, files=files) 

##############3##
#print(r.text)
#print(r.status_code)



# button for:
#url2 = "http://i.uestc.edu.cn/hmmcas/operon.php?qsf=ToSlide175938&tb=Table175938&sp=3"
#url2 = "http://i.uestc.edu.cn/hmmcas/operon.php?qsf=ToSlide031405&tb=Table031405&sp=3"
# Search links on buttons:
matches = re.findall("(http\:\/\/i\.uestc\.edu\.cn\/hmmcas\/operon\.php\?qsf=ToSlide.\d+\&tb=Table\d+\&sp=3)", r.text)
if len(matches):
	print("found " + matches[0])
else:
	return
url2 = matches[0]

table = requests.get(url2)



parser = etree.HTMLParser()
tree = etree.fromstring(table, parser)
results = tree.xpath('//tr/td[position()=2]')

print 'Column 2\n========'
for r in results:
    print r.text

