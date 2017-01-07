#!/usr/bin/env bats
#

#
# Idempotence test
# from https://github.com/neillturner/kitchen-ansible/issues/92
#

## FIXME! known failure currently
@test "Second run should change nothing" {
    skip "apt | grr dependencies install - ansible v2.2 ???"
#    if [ -f /etc/redhat-release -o X`lsb_release -rs` == 'X14.04' ]; then
#      skip "known fail but not explained as ansible module - pip setup: set grr virtualenv, Install Rekall"
#    fi
    run bash -c "ansible-playbook -i /tmp/kitchen/hosts /tmp/kitchen/default.yml -c local 2>&1 | tee /tmp/idempotency.test | grep -q 'changed=0.*failed=0' && exit 0 || exit 1"
    [ "$status" -eq 0 ]
}

