# weblogic-jmx-exporter

Based on [jmx_exporter](https://github.com/prometheus/jmx_exporter)

1. Copy getServerPortByName.py + setUserOverrides.sh to $DOMAIN_HOME/bin
2. Copy jmxexporter.yml $DOMAIN_HOME/config
3. Copy jmx_prometheus_javaagent.jar $DOMAIN_HOME/app
4. Config prometheus + import dashboard to grafana

As Result jmx port will be 1{$MANAGEDSERVER_PORT}
for example if MANAGED SERVER runnning on port 8004 jmxport will be 18004

