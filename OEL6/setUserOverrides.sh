# BEGIN JMXEXPORTER BLOCK
cat ${DOMAIN_HOME}/config/config.xml | awk 'BEGIN {i=0;print "<domain>"} {if(index($0,"<server>")>0){i=1};if(i==1){print $0};if(index($0,"</server>")){i=0};} END {print "</domain>"}' | grep -v "cluster" > ${DOMAIN_HOME}/config/config-jmx.xml
PORT=`python $DOMAIN_HOME/bin/getServerPortByName.py`
jmxexporter_port=1${PORT}
JAVA_OPTIONS+=" -javaagent:./app/jmx_prometheus_javaagent.jar=$jmxexporter_port:./config/jmxexporter.yml"
# END JMXEXPORTER BLOCK