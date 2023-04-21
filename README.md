# weblogic-jmx-exporter

Based on [jmx_exporter](https://github.com/prometheus/jmx_exporter)

1. Copy _getServerPortByName.py_ + _setUserOverrides.sh_ to __$DOMAIN_HOME/bin__
2. Copy _jmxexporter.yml_ to __$DOMAIN_HOME/config__
3. Copy _jmx_prometheus_javaagent.jar_ to __$DOMAIN_HOME/app__
4. Config prometheus + import dashboard to grafana

As Result jmx port will be _1{$MANAGEDSERVER_PORT}_
for example if MANAGED SERVER runnning on port _8004_ jmxport will be _18004_

If you have some problem with python script you can check it
```bash
export DOMAIN_HOME=<DOMAIN_HOME>
export SERVER_NAME=AdminServer
cd $DOMAIN_HOME/bin
python getServerPortByName.py
7001
```

__For old systems like RHEL/OEL/CentOS 6 you must use OEL6 folder.__
becouse this systems have old python version.