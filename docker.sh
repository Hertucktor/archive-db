#!/usr/bin/env bash

DOCKERIMAGE=archmongo:0.1
CONTAINERNAME=archivemongo

function check_docker_installed() {
  if [[ $(which docker) && $(docker --version) ]]; then
      echo "docker is installed"
    else
      echo "Install docker"
      exit
  fi
}

function create_docker_group() {
  if grep -q docker /etc/group
    then
      echo "group exists"
    else
      # Create the docker group.
      sudo groupadd docker

      # Add your user to the docker group.
      sudo usermod -aG docker "$USER"

      # activate the changes to groups
      newgrp docker

      echo "group has been successfully created"

      while true; do
        read -p "Do you wish to restart system and apply changes? [Yy/Nn]" yn
        case $yn in
            [Yy]* ) epoweroff --reboot; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
      done
  fi
}

function create_docker_image() {
  # build mongo db image
  docker build -t "$DOCKERIMAGE" .

  local result
  result=$(docker images -q "$DOCKERIMAGE" )
  echo "$result"
}

function run_docker_image() {
  # run image in detach mode
  if [ "$( docker container inspect -f '{{.State.Running}}' "$CONTAINERNAME" )" == "true" ]
    then
      echo "container $CONTAINERNAME is running"
    else
      docker run -d --name="$CONTAINERNAME" --publish 37017:27017 $DOCKERIMAGE
  fi
}



