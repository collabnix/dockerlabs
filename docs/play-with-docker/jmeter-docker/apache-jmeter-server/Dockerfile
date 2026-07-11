#This Dockerfile builds Apache JMeter Master Executable based on ajeetraina/apache-jmeter-base

FROM ajeetraina/apache-jmeter-base
LABEL Description="This image is used to start the Apache JMeter Server Executable" Vendor="Collabnix" Version="1.0"

# Ports required for JMeter Slaves/Server
EXPOSE 1099 50000

# Application to be executed to start the JMeter container
ENTRYPOINT $JMETER_HOME/bin/jmeter-server \
                        -Dserver.rmi.localport=50000 \
                        -Dserver_port=1099
