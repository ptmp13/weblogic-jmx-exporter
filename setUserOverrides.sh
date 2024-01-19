export wluser=CHANGEIT
export wlpass=CHANGEIT

checkjq=$(which jqq 2>/dev/null)
checkpy=$(which python 2>/dev/null)
check_admin_up=$(curl -s -XGET ${ADMIN_URL}>>/dev/null && echo "UP")

echo "checkjq: $checkjq! port: $PORT"
echo "checkpy: $checkpy! port: $PORT"

getPortFromRest()
{
	# Try get port from Rest
	if [ "$checkjq" != "" ]
	then
		echo "=============================================="
		echo "Try get port from Http api..."
		PORT=$(curl -s -u ${wluser}:${wlpass} -XGET ${ADMIN_URL}/management/weblogic/latest/serverConfig/servers/${SERVER_NAME}|jq -r '.listenPort // empty')
		echo "=============================================="
	else
		getPortFromAdminServer
	fi

	# If port still empty...
	if [ "$PORT" = "" ]
	then
		getPortFromAdminServer
	fi
}

getPortFromConfig()
{
	# Try get port from config.xml
	if [ "$checkpy" != "" -a "$PORT" = "" ]
	then	
		echo "=============================================="
		echo "Try get port from config.xml..."
		PORT=$(python $DOMAIN_HOME/bin/getServerPortByName.py)
		echo "=============================================="
	fi
}

getPortFromAdminServer()
{
	if [ -f /tmp/msport.txt ]
	then
		> /tmp/msport.txt
	fi
	# Try get port from AdminServer
	export T3ADMIN_URL="${ADMIN_URL/http/t3}"
	echo "=============================================="
	echo "Try get port from AdminServer...."
	$MW_HOME/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/bin/getPortFromAdminServer.py
	PORT=$(cat /tmp/msport.txt)
	echo "=============================================="

	# If PORT still empty...
	if [ "$PORT" = "" ] 
	then
		getPortFromConfig
	fi
}

if [ "$check_admin_up" = "UP" ]
then
	if [ "$wluser" != "" -a "$wlpass" != "" ]
	then
		getPortFromRest
	else
		getPortFromConfig
	fi
else
	getPortFromConfig
fi

if [ "$PORT" != "" ]
then
	echo "Managed Server Port: ${PORT}"
	jmxexporter_port=1${PORT}
	echo "Managed Server JMXExporterPort: ${PORT}"
	JAVA_OPTIONS+=" -javaagent:./app/jmx_prometheus_javaagent.jar=$jmxexporter_port:./config/jmxexporter.yml"
else
	echo "--------------------------------------------------"
	echo "Cant find port from managed server: ${SERVER_NAME}!"
	echo "--------------------------------------------------"
fi
