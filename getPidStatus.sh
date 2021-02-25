#!/bin/bash -eE

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
. "${SCRIPT_DIR}/env.sh"
LOG_DIR="/var/log/node"
LOG_FILE="node_pid_status.log"

PID=`ps -ax | grep "validator\-engine" | awk '{print $1}'`
echo "Validator engine PID: $PID"

        if [[ -z "${PID}" ]]
        then
            echo "$(date "+%Y-%m-%d %H:%M:%S"): Stopped!" >> $LOG_DIR/$LOG_FILE
            #${SCRIPT_DIR}/sendNotificationTelegram.sh "Node is down. Starting..."
            sleep 5
            ${SCRIPT_DIR}/run.sh
            sleep 5

            PID=`ps -ax | grep "validator\-engine" | awk '{print $1}'`

            if [[ -z ${PID} ]]
            then
                        echo "$(date "+%Y-%m-%d %H:%M:%S"): Start failed!" >> $LOG_DIR/$LOG_FILE
                        #${SCRIPT_DIR}/sendNotificationTelegram.sh "Node is still down! Check it manually"
                else
                        echo "New validator engine PID: $PID"
                        echo "$(date "+%Y-%m-%d %H:%M:%S"): Started!" >> $LOG_DIR/$LOG_FILE
                        #${SCRIPT_DIR}/sendNotificationTelegram.sh "Node is up!"
                fi
        else
            echo "$(date "+%Y-%m-%d %H:%M:%S"): Running..." >> $LOG_DIR/$LOG_FILE
        fi

exit 0
