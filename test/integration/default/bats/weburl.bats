#!/usr/bin/env bats

setup() {
    apt-get install -y curl >/dev/null || yum -y install curl >/dev/null
}

@test "should be able to retrieve cert - http://127.0.0.1:8000/server.pem" {
    run curl -sSq http://127.0.0.1:8000/server.pem
    [ "$status" -eq 0 ]
    [[ "$output" =~ "-----BEGIN CERTIFICATE-----" ]]
}

@test "should be able to access control - http://127.0.0.1:8000/control" {
    run curl -sSq http://127.0.0.1:8000/control
    [ "$status" -eq 52 ]
    [[ "$output" =~ "Empty reply from server" ]]
}

