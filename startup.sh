#!/bin/bash
source docker.sh

LOGFILE=dockerStartup.log
FILE=Dockerfile

# check for custom logfile
if [[ -f "$LOGFILE" ]]
  then
    echo "custom logfile $LOGFILE exists"
  else
    touch $LOGFILE
fi

check_docker_installed

if [[ -f "$FILE" ]]; then
    echo "$FILE exists."

    create_docker_group

    result=$(create_docker_image)

    if [[ -n $result ]]
    then
      echo "docker image: $DOCKERIMAGE exists"
      run_docker_image
    else
      echo "ERROR: $(date) docker image: $DOCKERIMAGE does not exists" > $LOGFILE
    fi
fi
