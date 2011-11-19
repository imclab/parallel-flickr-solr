#!/bin/sh -e

# Starts, stops, and restarts solr

# To make sure this runs at startup, do:
# update-rc.d solr.sh defaults

SOLR_MEMORY=1024m
SOLR_DIR="/fix/me"
SOLR_CORES="/fix/me"
SOLR_LOGS="/dev/null"

JAVA_START_OPTIONS="-Xmx$SOLR_MEMORY -Dsolr.solr.cores=$SOLR_CORES -Dsolr.solr.home=$SOLR_DIR -jar -DSTOP.PORT=8097 -DSTOP.KEY=stopkey start.jar"
JAVA_STOP_OPTIONS="-Xmx256m -Dsolr.solr.cores=$SOLR_CORES -Dsolr.solr.home=$SOLR_DIR -jar -DSTOP.PORT=8097 -DSTOP.KEY=stopkey start.jar"

JAVA="/usr/bin/java"

case $1 in
    start)
        echo "Starting Solr"
        cd $SOLR_DIR
        $JAVA $JAVA_START_OPTIONS 2> $SOLR_LOGS &
        ;;
    stop)
        echo "Stopping Solr"
        cd $SOLR_DIR
        $JAVA $JAVA_STOP_OPTIONS --stop
        ;;
    restart)
        $0 stop
        sleep 1
        $0 start
        ;;
    debug)
        echo "Starting Solr"
        cd $SOLR_DIR
        $JAVA $JAVA_START_OPTIONS
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|debug}" >&2
        exit 1
        ;;
esac
