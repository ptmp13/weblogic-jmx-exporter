# weblogic-jmx-exporter

Based on [jmx_exporter](https://github.com/prometheus/jmx_exporter)

1. Copy _getServerPortByName.py_ + _setUserOverrides.sh_ to __$DOMAIN_HOME/bin__
2. Copy _jmxexporter.yml_ to __$DOMAIN_HOME/config__
3. Copy _jmx_prometheus_javaagent.jar_ to __$DOMAIN_HOME/app__
4. Config prometheus + import dashboard to grafana

As Result jmx port will be _1{$MANAGEDSERVER_PORT}_
for example if MANAGED SERVER runnning on port _8004_ jmxport will be _18004_

