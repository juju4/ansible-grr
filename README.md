[![Build Status](https://travis-ci.org/juju4/ansible-grr.svg?branch=master)](https://travis-ci.org/juju4/ansible-grr)
# GRR ansible role - WORK IN PROGRESS

Ansible role to setup GRR Rapid Response
https://github.com/google/grr
http://grr-response.blogspot.ca/

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9

### Operating systems

Tested with vagrant only on Ubuntu 14.04
Redhat system's need to be build from source and is work in progress.

## Example Playbook

Just include this role in your list.
For example

```
- host: grr
  roles:
    - grr-server
```

Finish install by
```
$ sudo grr_config_updater initialize
```
You should only have to check values and enter web admin password.
(Note: log of 'Warning: Invalid utf8 character string' if using MysqlAdvanced Datastore)
```
$ . /usr/share/grr/scripts/shell_helpers.sh
$ grr_restart_all
```
and review web interfaces settings (enable cron job, checking clients there...)

Deploy on client either with scp (host path /usr/share/grr/executables), either through web UI

As for any services, you are recommended to do your homework with hardening.

## Variables

Default var can be used right away outside of domain and passwords 
obviously but should be fine for test run.

```
grr_debarchive_url: https://googledrive.com/host/0B1wsLqFoT7i2c3F0ZmI1RDJlUEU/grr-server_0.3.0-7_amd64.deb
grr_client_r: 3.0.0.7
grr_hostname: "{{ ansible_fqdn }}"
grr_domain: localhost
grr_admin_port: 8080
grr_frontend_port: 8000
grr_alert_email: "grr-monitoring@{{ grr_domain }}"
grr_alert_emergency: "grr-emergency@{{ grr_domain }}"
grr_admin_pass: adminpass

#grr_datastore: SqliteDataStore
grr_datastore: MysqlAdvanced
grr_datastore_mysql_host: localhost
## 0 meaning socket
grr_datastore_mysql_port: 0
grr_datastore_mysql_db: grrdb
grr_datastore_mysql_user: grr
grr_datastore_mysql_pass: grr

## do you want server to be covered?
## Note: can only be done if initialize is fully runned before as else client are not generated
grr_deploy_on_server: false
```

## Continuous integration

you can test this role with test kitchen.
In the role folder, run
```
$ kitchen verify
```

Known bugs
* can be very slow test/lot of disk I/O depending on your host. check enough memory is configured inside .kitchen.yml

## Known issues

Check
https://github.com/google/grr-doc/blob/master/troubleshooting.adoc
```
$ wget http://127.0.0.1:8000/server.pem
$ wget http://127.0.0.1:8000/control
$ sudo grr_end_to_end_tests --config /etc/grr/grr-server.yaml --verbose --local_client --local_worker
```

* Final configuration of grr need to fill /etc/grr/server.local.yaml by calling
```
# grr_config_updater initialize
```
Currently, it's not possible to automate this part

* If you want to send reports by email, need to configure email server (separate role)

* Default Data Store in /etc/grr/grr-server.yaml is Sqlite. Alternative are Mysql, MongoDB and a distributed in-house Sqlite (http://grr-response.blogspot.ca/2014/10/using-distributed-data-store-in-grr.html).

* for production setup, interface should be covered by a reverse proxy with separate authentication.

* Recover Artefacts
https://github.com/ForensicArtifacts/artifacts

? if mysqladvanced datastore, generate executables in rpm too (+exe+deb+pkg)

## License

BSD 2-clause


