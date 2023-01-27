import xml.etree.ElementTree as ET
import os

servername=os.getenv('SERVER_NAME')
domainhome=os.getenv('DOMAIN_HOME')

tree = ET.parse(domainhome+'/config/config.xml')

ns = {'domain': 'http://xmlns.oracle.com/weblogic/domain'}

root = tree.getroot()

for country in root.findall('domain:server',ns):
        name = country.find('domain:name', ns)
        if name.text == servername:
                port = country.find('domain:listen-port', ns)

                if name.text == "AdminServer":
                        lport=7001
                else:
                        lport=port.text

print(lport)
