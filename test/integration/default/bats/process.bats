#!/usr/bin/env bats

setup() {
    apt-get install -y curl || yum -y install curl
}

@test "process postgres should be running" {
    run pgrep postgres
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process rabbitmq should be running" {
    run pgrep rabbitmq
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process mig-api should be running" {
    run pgrep mig-api
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process mig-scheduler should be running" {
    run pgrep mig-scheduler
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "Can reach front-end http://localhost:8000/server.pm" {
    run curl -sSq http://localhost:8000/server.pm
    [ "$status" -eq 0 ]
    [[ "$output" =~ "\"version\":\"1.0\"" ]]
}

@test "Can reach front-end http://localhost:8000/control" {
    run curl -sSq http://localhost:8000/control
    [ "$status" -eq 0 ]
    [[ "$output" =~ "\"version\":\"1.0\"" ]]
}

@test "Can reach Admin UI http://localhost:8080" {
    run curl -sSq http://localhost:8080
    [ "$status" -eq 0 ]
    [[ "$output" =~ "\"version\":\"1.0\"" ]]
}

