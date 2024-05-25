# weblogic-jmx-exporter

Based on [jmx_exporter](https://github.com/prometheus/jmx_exporter)

1. Copy _getPortFromAdminServer.py_ + _getServerPortByName.py_ + _setUserOverrides.sh_ to __$DOMAIN_HOME/bin__
2. Copy _jmxexporter.yml_ to __$DOMAIN_HOME/config__
3. Copy _jmx_prometheus_javaagent.jar_ to __$DOMAIN_HOME/app__
4. Config prometheus + import dashboard to grafana. Prometheus service discovery file must be like **prometheus_wls_sd.yml** in repo. Becouse dashboard using vars from sd file (like *weblogic_domainUID*, *weblogic_serverName*)

As Result jmx port will be _1{$MANAGEDSERVER_PORT}_
for example if MANAGED SERVER runnning on port _8004_ jmxport will be _18004_

### Settings

Open setUserOverrides.sh and set variables:
1. _wluser_ - username who have at least __Monitor__ role!
2. _wlpass_ - password from wluser

You can dont set this vars, but in this case you cant get port for Dynamic Cluster servers.
For 12c weblogic best way to get port from REST API (jq must install for parse output), but its way reqired wluser/wlpass.

### Problems

#### If you have some problem with python script 

Check it
```bash
export DOMAIN_HOME=<DOMAIN_HOME>
export SERVER_NAME=AdminServer
cd $DOMAIN_HOME/bin
python getServerPortByName.py
7001
```

#### If you have problem with RESTAPI

Check it
```bash
export ADMIN_URL="http://lost.com:7001"
export SERVER_NAME=AdminServer
export wluser=monitor
export wlpass=test
curl -u ${wluser}:${wlpass} -XGET ${ADMIN_URL}/management/weblogic/latest/serverConfig/servers/${SERVER_NAME}
```
In output you must see field __listenPort__

#### For wlst 

Check it
```bash
export DOMAIN_HOME=<DOMAIN_HOME>
export T3ADMIN_URL="t3://lost.com:7001"
export SERVER_NAME=AdminServer
export wluser=monitor
export wlpass=test
$MW_HOME/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/bin/getPortFromAdminServer.py
```

### Old systems like RHEL/OEL/CentOS 6

__For old systems like RHEL/OEL/CentOS 6 you must use OEL6 folder.__
becouse this systems have old python version.

### Info about setUserOverrides.sh

This support 3 ways for get port for current managed server
1) REST API - get using curl + jq
2) WLST - jython script 
3) Parse config.xml - python

Priority 1-2-3 becouse only 1,2 support Dynamic Clusters, therefore 100% will return port but its required wluser/wlport + jq 

## Prometheus SD sample

You must add managed server like in file
__prometheus_wls_sd.yml__
