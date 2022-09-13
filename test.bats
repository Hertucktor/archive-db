#!/usr/bin/env bash

setup() {
  source ./startup.sh
  load 'test/test_helper/bats-support/load'
  load 'test/test_helper/bats-assert/load'
  load 'test/test_helper/bats-files/load'
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
  PATH="$DIR/../src:$PATH"
}

@test "can run script" {
  ./startup.sh
}

@test "docker is installed" {
  run check_docker_installed

  assert_output "docker is installed"
}

@test "docker user exists" {
  run create_docker_group 'n'

  assert_output "group exists"
}

@test "docker image exists" {
  run create_docker_image

  assert_equal "$(docker images -q '$DOCKERIMAGE' )"
}

@test "docker container is running" {
  run run_docker_image

  assert_output "container $CONTAINERNAME is running"
}