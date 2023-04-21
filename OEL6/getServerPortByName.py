import xml.etree.ElementTree as ET
import os

servername=os.getenv('SERVER_NAME')
domainhome=os.getenv('DOMAIN_HOME')

tree = ET.parse(domainhome+'/config/config-jmx.xml')

ns = 'http://xmlns.oracle.com/weblogic/domain'

root = tree.getroot()
lport = ""

for country in root.findall('server'):
   name = country.find('name')
   if name.text == servername:
	   port = country.find('listen-port')

	   if name.text == "AdminServer":
		lport=7001
	   else:
		lport=port.text