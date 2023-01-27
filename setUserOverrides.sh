# BEGIN clubpro_domain JMXEXPORTER BLOCK 
PORT=`python $DOMAIN_HOME/bin/getServerPortByName.py`
jmxexporter_port=1${PORT}
JAVA_OPTIONS+=" -javaagent:./app/jmx_prometheus_javaagent.jar=$jmxexporter_port:./config/jmxexporter.yml"
# END clubpro_domain JMXEXPORTER BLOCK
