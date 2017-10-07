from selenium import webdriver
from selenium.webdriver.common.keys import Keys
driver = webdriver.Firefox()
driver.get('http://i.uestc.edu.cn/hmmcas/index.html')
element = driver.find_element_by_id('txt1')
inseq=''
q=open('NC_016025.faa','r')
for i in q:
	inseq+=i+'\n'

q.close()
inseq=inseq.replace('\n\n','\n')
element.send_keys(inseq)
driver.find_element_by_id("submit").click()
driver.forward()

driver.find_element_by_link_text('Higher Sensitivity').click()


