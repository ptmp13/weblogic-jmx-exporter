import sys
import os

#mserver=sys.argv[1]
mserver=os.getenv('SERVER_NAME')
wluser=os.getenv('wluser')
wlpass=os.getenv('wlpass')
adminurl=os.getenv('T3ADMIN_URL')

def connectToAdminServer():
  #Connect to Admin Server
  try:
      connect(wluser,wlpass,url=adminurl)
  except:
      print "---------------------------------"
      print "Cannot connect to AdminServer! Check is AdminServer running!"
      print "---------------------------------"
      exit(exitcode=3)

connectToAdminServer()
cd('/Servers/'+mserver)
portfile='/tmp/msport.txt'
f=open(portfile, 'w')
f.write(str(cmo.getListenPort()));
f.truncate()
f.close()
