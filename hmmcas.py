# before use run in command shell:
# pip install pipenv
# pipenv install requests
# pipenv install BeautifulSoup
# pipenv install lxml
# pip install BeautifulSoup
# pip install beautifulsoup4
# pip install lxml

import requests
import re
from bs4 import BeautifulSoup



#r = requests.get('http://immunet.cn/hmmcas') # this is optional

url = "http://immunet.cn/hmmcas/upload2.php"
payload = {'sequence': '>gi|347755963|ref|YP_004863525.1| hypothetical protein [Candidatus Chloracidobacterium thermophilum B] MSDTTPLPFPPHYDPIQTVAAEYPGTAPQALFAPAMAWQQAHSLRPAADDARRAHLLVIDMQVDFCFPSGTLYVAGRSGTGGTDALRRTVEFMYRYLPWISEITCTLDSHVPGQVFFPGAHLTEDGAPVAPHTVITAADYRAGRYRPNPALAAQLGVTTEWLTHQVTDYCTRLEATGKYALYVWPYHCLVGTAGHRLAGVLADACLFHAFARGAANAPVLKGDSPLTENYSVFAPEVTTCWDGQPMPGAVRHEALLKRLLTADVILVAGLASSHCVAASVADLLAFVQEHNPYLAHRIVLLRDAMAPVVVPGADFTDAAEQALASFEAAGARVLTTDDPVEAWWG', 
			'key2': 'value2'}

print("request to "+ url)		
#r = requests.post(url, data=payload)

################# alernate
files = {'uploadfile': open('NC_016025.faa', 'rb')}
r = requests.post(url, files=files) 

#################
#print(r.text)
text_file = open("Output1.html", "w")
text_file.write(r.text)
text_file.close()
#print(r.status_code)



# button for:
#url2 = "http://i.uestc.edu.cn/hmmcas/operon.php?qsf=ToSlide175938&tb=Table175938&sp=3"
#url2 = "http://i.uestc.edu.cn/hmmcas/operon.php?qsf=ToSlide031405&tb=Table031405&sp=3"
# Search links on buttons:
matches = re.findall("(http\:\/\/i\.uestc\.edu\.cn\/hmmcas\/operon\.php\?qsf=ToSlide.\d+\&tb=Table\d+\&sp=3)", r.text)
if len(matches):
	print("found " + matches[0])

	url2 = matches[0]

	r = requests.get(url2)





from bs4 import BeautifulSoup

print(r.text)

text_file = open("Output2.html", "w")
text_file.write(r.text)
text_file.close()

soup = BeautifulSoup(r.text, "lxml")

for row in soup.findAll('table')[0].tbody.findAll('tr'):
    first_column = row.findAll('th')[0].contents
    third_column = row.findAll('td')[2].contents
    print (first_column, third_column)




# from lxml import etree
# parser = etree.HTMLParser()
# tree = etree.fromstring(table, parser)
# results = tree.xpath('//tr/td[position()=2]')

# print ('Column 2\n========')
# for r in results:
#     print (r.text)


