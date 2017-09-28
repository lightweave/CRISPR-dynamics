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
import json



# r = requests.get('http://immunet.cn/hmmcas') # this is optional
# url = "http://immunet.cn/hmmcas/index.html"


testgenome = open('NC_016025.faa', 'r').read()
# print(testgenome)
payload = {'sequence': testgenome,
			'submit': 'Run HMMCAS'}

	
url = "http://immunet.cn/hmmcas/upload2.php"

print("request to "+ url)
headers = {'Host': 'immunet.cn',
'Connection': 'keep-alive',
# 'Content-Length': '400435',
'Cache-Control': 'max-age=0',
'Origin': 'http://immunet.cn',
'Upgrade-Insecure-Requests': '1',
'Content-Type': 'multipart/form-data', 
'Save-Data': 'on',
'User-Agent': "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",
'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
'Referer': 'http://immunet.cn/hmmcas/index.html',
'Accept-Encoding': 'gzip, deflate',
'Accept-Language': 'en-US,en;q=0.8,ru;q=0.6'
}
r = requests.post(url, data=payload, headers=headers)
# print(r.request.body)
print(r.request.headers)
################# alernate

# files = {'uploadfile': open('NC_016025.faa', 'rb')}
# r = requests.post(url, files=files) 

#################
#print(r.text)
text_file = open("Output1.html", "w")
text_file.write(r.text)
text_file.close()
#print(r.status_code)

matches = re.findall("(tables\/ToSlide\d+\.json)", r.text)
if len(matches):
	print("found " + matches[0])
	url2 = "http://immunet.cn/hmmcas/" + matches[0]+ "?limit=10&offset=0&sort=name&order=desc"
	# http://immunet.cn/hmmcas/tables/ToSlide225044.json?limit=10&offset=0&sort=name&order=desc
r = requests.get(url2)

text_file = open("Output1j.html", "w")
text_file.write(r.json())
text_file.close()


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


