#!/bin/bash

source "`dirname "$0"`/functions.sh"

add_classpath ${ISPN_HOME}/etc
add_classpath ${ISPN_HOME}/modules/memcached/*.jar
add_classpath ${ISPN_HOME}/modules/hotrod/*.jar
add_classpath ${ISPN_HOME}/modules/websocket/*.jar
add_classpath ${ISPN_HOME}/modules/cli-server/*.jar
add_classpath ${ISPN_HOME}/modules/memcached/runtime-classpath.txt
add_classpath ${ISPN_HOME}/modules/hotrod/runtime-classpath.txt
add_classpath ${ISPN_HOME}/modules/websocket/runtime-classpath.txt
add_classpath ${ISPN_HOME}/modules/cli-server/runtime-classpath.txt

add_jvm_args $JVM_PARAMS
#add_jvm_args '-Djgroups.bind_addr=127.0.0.1'
add_jvm_args '-Djava.net.preferIPv4Stack=true'

# RHQ monitoring options
add_jvm_args '-Dcom.sun.management.jmxremote.ssl=false'
add_jvm_args '-Dcom.sun.management.jmxremote.authenticate=false'
add_jvm_args -Dcom.sun.management.jmxremote.port=$(find_tcp_port)
add_jvm_args -DCFGPath=/var/lib/infinispan/etc/clearwater

# Workaround for JDK6 NPE: http://bugs.sun.com/view_bug.do?bug_id=6427854
add_jvm_args '-Dsun.nio.ch.bugLevel=""'

# Sample JPDA settings for remote socket debugging
#add_jvm_args "-Xrunjdwp:transport=dt_socket,address=8686,server=y,suspend=n"

# LOG4J configuration
# LOG4J_CONFIG=file:///${ISPN_HOME}/etc/log4j.xml

add_program_args -c "/var/lib/infinispan/etc/clearwater/cache-config.xml" -r memcached -p 11211

start org.infinispan.server.core.Main
